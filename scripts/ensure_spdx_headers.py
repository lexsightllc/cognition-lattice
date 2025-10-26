#!/usr/bin/env python3
# SPDX-License-Identifier: MPL-2.0
"""Ensure files contain an MPL-2.0 SPDX identifier."""

from __future__ import annotations

import pathlib
import sys
from typing import Iterable

SPDX_LINE = "SPDX-License-Identifier: MPL-2.0"

COMMENT_STYLES = {
    '.py': '#',
    '.pyi': '#',
    '.sh': '#',
    '.bash': '#',
    '.zsh': '#',
    '.ps1': '#',
    '.psm1': '#',
    '.psd1': '#',
    '.toml': '#',
    '.ini': '#',
    '.cfg': '#',
    '.yaml': '#',
    '.yml': '#',
    '.txt': '#',
    '.rst': '..',
    '.md': '<!--',
    '.cjs': '//',
    '.js': '//',
    '.ts': '//',
    '.tsx': '//',
    '.rs': '//',
    '.go': '//',
}

SHEBANG_COMMENT = '#'
HASH_COMMENT_FILES = {'Dockerfile', 'Makefile'}
SKIP_FILES = {'LICENSE', 'NOTICE', 'THIRD_PARTY_NOTICES'}


def determine_style(path: pathlib.Path) -> str | None:
    if path.name in HASH_COMMENT_FILES:
        return '#'
    if path.suffix:
        return COMMENT_STYLES.get(path.suffix)
    try:
        first_line = path.read_text(encoding='utf-8').splitlines()[0]
    except (UnicodeDecodeError, IndexError, FileNotFoundError):
        return None
    if first_line.startswith('#!'):
        return SHEBANG_COMMENT
    return None


def ensure_header(path: pathlib.Path) -> bool:
    if not path.exists() or path.is_dir():
        return False
    if path.name in SKIP_FILES:
        return False
    try:
        content = path.read_text(encoding='utf-8')
    except UnicodeDecodeError:
        return False
    if SPDX_LINE in content:
        return False
    style = determine_style(path)
    if style is None:
        return False
    lines = content.splitlines()
    insert_at = 0
    if lines and lines[0].startswith('#!'):
        insert_at = 1
    if style == '#':
        header = f'# {SPDX_LINE}'
    elif style == '//':
        header = f'// {SPDX_LINE}'
    elif style == '..':
        header = f'.. {SPDX_LINE}'
    elif style == '<!--':
        header = f'<!-- {SPDX_LINE} -->'
    else:
        return False
    new_lines = lines[:insert_at] + [header] + lines[insert_at:]
    ending = '\n' if content.endswith('\n') else ''
    path.write_text('\n'.join(new_lines) + ending, encoding='utf-8')
    return True


def main(argv: Iterable[str]) -> int:
    changed = False
    for arg in argv:
        changed |= ensure_header(pathlib.Path(arg))
    return 0 if not changed else 0


if __name__ == '__main__':
    raise SystemExit(main(sys.argv[1:]))
