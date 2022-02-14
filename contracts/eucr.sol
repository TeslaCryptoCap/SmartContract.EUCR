// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

import "OpenZeppelin/openzeppelin-contracts@4.2.0/contracts/token/ERC20/ERC20.sol";
import "OpenZeppelin/openzeppelin-contracts@4.2.0/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "OpenZeppelin/openzeppelin-contracts@4.2.0/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "OpenZeppelin/openzeppelin-contracts@4.2.0/contracts/access/AccessControl.sol";

contract DinarStableCoin is ERC20, ERC20Burnable, ERC20Snapshot, AccessControl {
    bytes32 public constant SNAPSHOT_ROLE = keccak256("SNAPSHOT_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address account) ERC20("Euro StableCoin", "EUCR") {
        _setupRole(DEFAULT_ADMIN_ROLE, account);
        _setupRole(SNAPSHOT_ROLE, account);
        _mint(msg.sender, 1000 * 10 ** decimals());
        _setupRole(MINTER_ROLE, account);
    }

    function snapshot() public {
        require(hasRole(SNAPSHOT_ROLE, msg.sender), "The sender must be defined as a SNAPSHOT_ROLE in the deployed contract");
        _snapshot();
    }

    function mint(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "The sender must be defined as a MINTER_ROLE in the deployed contract");
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}