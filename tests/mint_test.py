import pytest

@pytest.fixture
def deployDinar(DinarStableCoin, accounts):
    account = accounts[0]
    return DinarStableCoin.deploy(account, {"from": account})


def test_mint(deployDinar, accounts):
    deployDinar.mint(accounts[1], 10)
    print("The test_mint ", dir(deployDinar), deployDinar.balanceOf(accounts[1]))
    assert deployDinar.balanceOf(accounts[1]) == 10
    
