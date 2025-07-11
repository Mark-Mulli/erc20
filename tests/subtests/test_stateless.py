import pytest
from contracts.subfolder import stateless_fuzz_solvable
from hypothesis import given, HealthCheck, settings
from boa.test.strategies import strategy


@pytest.fixture(scope="function")
def contract():
    return stateless_fuzz_solvable.deploy()


@settings(
    max_examples=1000, suppress_health_check=[HealthCheck.function_scoped_fixture]
)
@given(input=strategy("uint256"))
def test_always_run_input(contract, input):
    print(input)
    assert contract.always_returns_input_number(input) == input
