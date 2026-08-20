#!/usr/bin/env python3

import os
import re
import sys
import subprocess
from pathlib import Path

CASE = sys.argv[1] if len(sys.argv) > 1 else ""
FILES = [Path(x) for x in sys.argv[2:]]

VALID_CASES = {
    "camel",
    "snake",
    "kebab",
    "spaced",
}
