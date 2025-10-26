import json
from pathlib import Path
from typing import Dict, Any
from jsonschema import validate, ValidationError

REPO_ROOT = Path(__file__).resolve().parents[2]
SCHEMAS_DIR = REPO_ROOT / "configs" / "schemas"

_schema_cache = {}


def _load_schema(intent_type: str) -> Dict[str, Any]:
    if intent_type not in _schema_cache:
        path = SCHEMAS_DIR / f"{intent_type}.json"
        if not path.exists():
            raise ValidationError(f"No schema found for intent '{intent_type}'")
        with path.open("r", encoding="utf-8") as handle:
            _schema_cache[intent_type] = json.load(handle)
    return _schema_cache[intent_type]


def validate_intent(intent: Dict[str, Any]) -> None:
    intent_type = intent.get('intent')
    if not intent_type:
        raise ValidationError('intent field missing')
    schema = _load_schema(intent_type)
    validate(instance=intent, schema=schema)
