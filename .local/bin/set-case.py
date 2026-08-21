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

# Determine whether a complete token should be preserved
# Patterns are matched against the entire token
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

    # First split on separators
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

        # Separate acronym + normal word
        chunk = re.sub(
            r"([A-Z]+)([A-Z][a-z])",
            r"\1 \2",
            chunk,
        )
        
        # Separate lower/digit -> uppercase
        chunk = re.sub(
            r"([a-z0-9])([A-Z])",
            r"\1 \2",
            chunk,
        )
        
        # Separate letters -> numbers
        chunk = re.sub(
            r"([A-Za-z])([0-9])",
            r"\1 \2",
            chunk,
        )

        # Separate numbers -> letters
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
# Case Formatting // Under Construction
# ──────────────────────────────
