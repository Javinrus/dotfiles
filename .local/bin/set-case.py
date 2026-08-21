#!/usr/bin/env python3

from __future__ import annotations

import argparse
import os
import re
import sys
import tempfile
import tomllib
from pathlib import Path

VALID_CASES = ("camel", "snake", "kebab", "spaced")

# ──────────────────────────────
# Configuration
# ──────────────────────────────

XDG_CONFIG_HOME = Path(
    os.environ.get(
        "XDG_CONFIG_HOME",
        Path.home() / ".config",
    )
)

CONFIG_PATH = XDG_CONFIG_HOME / "bin" / "set-case.toml"

def load_config() -> tuple[set[str], list[re.Pattern[str]]]:
    if not CONFIG_PATH.exists():
        return set(), []

    try:
        with CONFIG_PATH.open("rb") as file:
            config = tomllib.load(file)

    except (OSError, tomllib.TOMLDecodeError) as exc:
        raise RuntimeError(
            f"Cannot read configuration:\n"
            f"{CONFIG_PATH}\n\n"
            f"{exc}"
        ) from exc

    preserve = config.get("preserve", {})

    if not isinstance(preserve, dict):
        raise RuntimeError(
            f"[preserve] must be a TOML table:\n"
            f"{CONFIG_PATH}"
        )

    words = preserve.get("words", [])
    patterns = preserve.get("patterns", [])

    if not isinstance(words, list):
        raise RuntimeError(
            f"'words' must be a TOML array:\n"
            f"{CONFIG_PATH}"
        )

    if not isinstance(patterns, list):
        raise RuntimeError(
            f"'patterns' must be a TOML array:\n"
            f"{CONFIG_PATH}"
        )

    preserve_words: set[str] = set()

    for word in words:
        if not isinstance(word, str):
            raise RuntimeError(
                f"Every item in 'words' must be a string:\n"
                f"{CONFIG_PATH}"
            )

        preserve_words.add(word.casefold())

    preserve_patterns: list[re.Pattern[str]] = []

    for pattern in patterns:
        if not isinstance(pattern, str):
            raise RuntimeError(
                f"Every item in 'patterns' must be a string:\n"
                f"{CONFIG_PATH}"
            )

        try:
            preserve_patterns.append(
                re.compile(pattern, re.IGNORECASE)
            )
        except re.error as exc:
            raise RuntimeError(
                f"Invalid preserve pattern:\n"
                f"{pattern}\n\n"
                f"{exc}"
            ) from exc

    return preserve_words, preserve_patterns

# ──────────────────────────────
# Tokenization
# ──────────────────────────────

# Determine whether a token should be preserved
def is_preserved(
    token: str,
    preserve_words: set[str],
    preserve_patterns: list[re.Pattern[str]],
) -> bool:
    if token.casefold() in preserve_words:
        return True

    return any(
        pattern.fullmatch(token)
        for pattern in preserve_patterns
    )

# Convert a filename stem into logical words
def tokenize(
    text: str,
    preserve_words: set[str],
    preserve_patterns: list[re.Pattern[str]],
) -> list[str]:
    # Turn anything that isn't a letter/number into space
    text = re.sub(
        r"[^\w]+",
        " ",
        text,
        flags=re.UNICODE,
    )
    
    # "_" is a separator, not part of a word
    text = text.replace("_", " ")

    chunks = text.split()
    
    result: list[str] = []

    for chunk in chunks:

        # A complete configured word is kept intact
        if is_preserved(
            chunk,
            preserve_words,
            preserve_patterns,
        ):
            result.append(chunk.casefold())
            continue

        chunk = re.sub(
            r"([A-Z]+)([A-Z][a-z])",
            r"\1 \2",
            chunk,
        )
        
        chunk = re.sub(
            r"([a-z0-9])([A-Z])",
            r"\1 \2",
            chunk,
        )
        
        chunk = re.sub(
            r"([A-Za-z])([0-9])",
            r"\1 \2",
            chunk,
        )

        chunk = re.sub(
            r"([0-9])([A-Za-z])",
            r"\1 \2",
            chunk,
        )

        result.extend(
            part.casefold()
            for part in chunk.split()
            if part
        )

    return result

# ──────────────────────────────
# Case Formatting
# ──────────────────────────────

def format_words(words: list[str], case: str) -> str:
    if not words:
        return ""

    if case == "camel":
        return (
            words[0]
            + "".join(
                word[:1].upper() + word[1:]
                for word in words[1:]
            )
        )

    if case == "snake":
        return "_".join(words)

    if case == "kebab":
        return "-".join(words)

    if case == "spaced":
        return " ".join(words)

    raise ValueError(f"Unknown case: {case}")

# ──────────────────────────────
# Filename Handling
# ──────────────────────────────

# Split filename into stem + extension
def split_name(path: Path) -> tuple[str, str]:
    name = path.name

    if name.startswith(".") and name.count(".") == 1:
        return name, ""

    suffix = path.suffix

    if not suffix:
        return name, ""

    return name[:-len(suffix)], suffix

def make_target_name(
    path: Path,
    case: str,
    preserve_words: set[str],
    preserve_patterns: list[re.Pattern[str]],
) -> str:
    stem, suffix = split_name(path)

    # Preserve the leading dot for dotfiles
    leading_dot = stem.startswith(".") and stem != "."

    if leading_dot:
        stem = stem[1:]

    words = tokenize(
        stem,
        preserve_words,
        preserve_patterns,
    )

    if not words:
        # Don't turn something into an empty filename
        return path.name

    converted = format_words(words, case)

    if leading_dot:
        converted = "." + converted

    return converted + suffix

# ──────────────────────────────
# Under Making
# ──────────────────────────────
