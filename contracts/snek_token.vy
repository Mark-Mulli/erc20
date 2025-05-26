# pragma version 0.4.1

"""
@license MIT
@title snek_token
@author MarkMulli
@notice This is my ERC20 token!
"""

# ------------------------------------------------------------------
#                             IMPORTS
# ------------------------------------------------------------------

from ethereum.ercs import IERC20

implements: IERC20

from pcaversaccio.snekmate.src.snekmate.auth import ownable as ow
from pcaversaccio.snekmate.src.snekmate.tokens import erc20

initializes: ow
initializes: erc20[ownable := ow]

exports: erc20.__interface__

# ------------------------------------------------------------------
#                         STATE VARIABLES
# ------------------------------------------------------------------

NAME: constant(String[25]) = "snek_token"
SYMBOL: constant(String[5]) = "SNEK"
DECIMALS: constant(uint8) = 18
EIP712_VERSION: constant(String[20]) = "1"

# ------------------------------------------------------------------
#                            FUNCTIONS
# ------------------------------------------------------------------

@deploy
def __init__(initial_supply: uint256):
    ow.__init__()
    erc20.__init__(NAME, SYMBOL, DECIMALS, NAME, EIP712_VERSION)
    erc20._mint(msg.sender, initial_supply)

@external
def burned(amount: uint256):
    """
    @notice Burns a specific amount of tokens from the caller's account.
    @param amount The amount of tokens to burn.
    """
    erc20._burn(msg.sender, amount)