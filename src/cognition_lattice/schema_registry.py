"""Simple schema registry."""

import json
from functools import lru_cache
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
SCHEMA_ROOT = REPO_ROOT / "configs" / "schemas"


@lru_cache(maxsize=128)
def load_schema(name: str) -> dict:
    """Load a schema from the canonical configuration directory."""
    path = SCHEMA_ROOT / name
    if not path.exists():
        raise FileNotFoundError(f"Schema {name} not found in {SCHEMA_ROOT}")
    return json.loads(path.read_text())
