# pragma version 0.4.1

from pcaversaccio.snekmate.src.snekmate.auth import ownable as ow
from pcaversaccio.snekmate.src.snekmate.tokens import erc20


initializes: ow
initializes: erc20[ownable := ow]


NAME: constant(String[25]) = "snek_token"
SYMBOL: constant(String[5]) = "SNEK"
DECIMALS: constant(uint8) = 18
EIP712_VERSION: constant(String[20]) = "1"

@deploy
def __init__():
    ow.__init__()
    erc20.__init__(NAME, SYMBOL, DECIMALS, NAME, EIP712_VERSION)


    


# pcaversaccio.snekmate.src.snekmate.auth
# pcaversaccio.snekmate.src.snekmate.tokens