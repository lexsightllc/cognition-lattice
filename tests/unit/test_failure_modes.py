import pytest

from cognition_lattice.agent_core import AgentCore
from cognition_lattice.sios_messaging.inmemory import InMemoryBroker


def test_invalid_intent():
    broker = InMemoryBroker()
    # intentionally missing intent field
    broker.send_intent({"args": "foo"})
    core = AgentCore()
    for intent in broker.receive_intents():
        result = core.dispatch(intent)
        assert result["status"] == "error"
