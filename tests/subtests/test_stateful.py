from hypothesis.stateful import RuleBasedStateMachine, rule
from contracts.subfolder import stateful_fuzz_solvable
from boa.test.strategies import strategy
from hypothesis import settings


class StatefulFuzzer(RuleBasedStateMachine):
    def __init__(self):
        super().__init__()
        self.contract = stateful_fuzz_solvable.deploy()
        print("Delpoyed Contract")

    @rule(new_number=strategy("uint256"))
    def change_number(self, new_number):
        self.contract.change_number(new_number)
        print(f"    Changed number to {new_number}")

    @rule(input=strategy("uint256"))
    def always_returns_input_number(self, input):
        response = self.contract.always_returns_input_number(input)
        print(f"   always_returns with {input}")
        assert response == input, f"Expected {input}, but got {response}"


TestStatefulFuzzing = StatefulFuzzer.TestCase
TestStatefulFuzzing.settings = settings(
    max_examples=1000,
    stateful_step_count=50,
)
