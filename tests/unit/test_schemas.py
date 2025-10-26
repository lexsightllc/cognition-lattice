# SPDX-License-Identifier: MPL-2.0
import json
import json
from pathlib import Path

from cognition_lattice.intent_gateway import IntentModel


def test_schemas_match_intent_model():
    model_fields = set(IntentModel.model_fields.keys())
    schema_dir = Path('configs') / 'schemas'
    for path in schema_dir.glob('*.json'):
        schema = json.loads(path.read_text())
        schema_fields = set(schema.get('properties', {}).keys())
        assert schema_fields.issubset(model_fields)
