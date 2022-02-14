#!/usr/bin/python3

from brownie import DinarStableCoin, accounts


def main():
    account = accounts[0]
    erc20 = DinarStableCoin.deploy(account, {"from": account})

