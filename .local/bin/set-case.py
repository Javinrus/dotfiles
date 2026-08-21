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
