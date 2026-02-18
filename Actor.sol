// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MyToken.sol";

contract Actor {
    function doTransferFrom(MyToken token, address from, address to, uint256 amount) external {
        token.transferFrom(from, to, amount);
    }
    function doApprove(MyToken token, address spender, uint256 amount) external {
        token.approve(spender, amount);
    }
    function doBurnFrom(MyToken token, address account, uint256 amount) external {
        token.burnFrom(account, amount);
    }
    function doMint(MyToken token, address to, uint256 amount) external {
        token.mint(to, amount);
    }
}