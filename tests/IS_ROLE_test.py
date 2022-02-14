import pytest
import sha3

@pytest.fixture
def deployDinar(DinarStableCoin, accounts):
    account = accounts[0]
    return DinarStableCoin.deploy(account, {"from": account})

def test_is_minter_role(deployDinar, accounts):
    k = sha3.keccak_256()
    k.update(b"MINTER_ROLE")
    print("Here we are ", k.hexdigest(), dir (deployDinar))
    assert deployDinar.hasRole(k.hexdigest(), accounts[0].address)

def test_is_spanshot_role(deployDinar, accounts):
    k = sha3.keccak_256()
    k.update(b"SNAPSHOT_ROLE")
    print("Here we are ", k.hexdigest(), dir (deployDinar))
    assert deployDinar.hasRole(k.hexdigest(), accounts[0].address)

