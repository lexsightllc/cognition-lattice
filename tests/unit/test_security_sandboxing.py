import pytest

from cognition_lattice.agent_sandbox import run_agent_subprocess

@pytest.mark.asyncio
async def test_sandbox():
    result = await run_agent_subprocess(
        "cognition_lattice.async_echo_agent", {"intent": "echo", "args": "hi"}
    )
    assert result
