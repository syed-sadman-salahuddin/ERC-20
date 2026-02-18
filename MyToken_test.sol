// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "remix_tests.sol";
import "remix_accounts.sol";
import "./MyToken.sol";
import "./Actor.sol";

contract CoreERC20Test {
    MyToken token;
    address owner;
    address user1;
    address user2;
    Actor actor;

    function beforeEach() public {
        token = new MyToken();
        owner = address(this);
        user1 = TestsAccounts.getAccount(0);
        user2 = TestsAccounts.getAccount(1);
        actor = new Actor();
    }

    function testDeployment() public {
        uint256 expected = 1000 * 10 ** 18;
        Assert.equal(token.name(), "MyToken", "name");
        Assert.equal(token.symbol(), "MTK", "sym");
        Assert.equal(token.totalSupply(), expected, "total");
        Assert.equal(token.balanceOf(owner), expected, "bal");
    }

    function testTransfer() public {
        token.transfer(user1, 200 * 10 ** 18);
        Assert.equal(token.balanceOf(user1), 200 * 10 ** 18, "recv");
        Assert.equal(token.balanceOf(owner), 800 * 10 ** 18, "send");
    }

    function testTransferInsufficient() public {
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doTransferFrom(address,address,address,uint256)", token, address(actor), user1, 100 * 10 ** 18)
        );
        Assert.ok(!s, "insuf");
    }

    function testApprove() public {
        token.approve(user1, 100 * 10 ** 18);
        Assert.equal(token.allowance(owner, user1), 100 * 10 ** 18, "app");
    }

    function testTransferFrom() public {
        token.approve(address(actor), 150 * 10 ** 18);
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doTransferFrom(address,address,address,uint256)", token, owner, user2, 150 * 10 ** 18)
        );
        Assert.ok(s, "tf");
        Assert.equal(token.balanceOf(user2), 150 * 10 ** 18, "recv");
    }

    function testTransferFromNoAllowance() public {
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doTransferFrom(address,address,address,uint256)", token, owner, user1, 50 * 10 ** 18)
        );
        Assert.ok(!s, "no");
    }

    function testTransferFromExceeds() public {
        token.approve(address(actor), 50 * 10 ** 18);
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doTransferFrom(address,address,address,uint256)", token, owner, user2, 100 * 10 ** 18)
        );
        Assert.ok(!s, "exceed");
    }
}


contract MintBurnTest {
    MyToken token;
    address owner;
    address user1;
    Actor actor;

    function beforeEach() public {
        token = new MyToken();
        owner = address(this);
        user1 = TestsAccounts.getAccount(0);
        actor = new Actor();
    }

    function testMintByOwner() public {
        token.mint(user1, 500 * 10 ** 18);
        Assert.equal(token.balanceOf(user1), 500 * 10 ** 18, "mint");
        Assert.equal(token.totalSupply(), 1500 * 10 ** 18, "supply");
    }

    function testMintZero() public {
        uint256 before = token.balanceOf(user1);
        token.mint(user1, 0);
        Assert.equal(token.balanceOf(user1), before, "mint0");
    }

    function testMintToZero() public {
        (bool s, ) = address(token).call(
            abi.encodeWithSignature("mint(address,uint256)", address(0), 100 * 10 ** 18)
        );
        Assert.ok(!s, "toZero");
    }

    function testMintNonOwner() public {
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doMint(address,address,uint256)", token, user1, 100 * 10 ** 18)
        );
        Assert.ok(!s, "nonOwn");
    }

    function testBurnByOwner() public {
        token.burn(100 * 10 ** 18);
        Assert.equal(token.balanceOf(owner), 900 * 10 ** 18, "burn");
        Assert.equal(token.totalSupply(), 900 * 10 ** 18, "supply");
    }

    function testBurnZero() public {
        uint256 before = token.balanceOf(owner);
        token.burn(0);
        Assert.equal(token.balanceOf(owner), before, "burn0");
    }

    function testBurnInsufficient() public {
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doBurnFrom(address,address,uint256)", token, address(actor), 100 * 10 ** 18)
        );
        Assert.ok(!s, "burnIns");
    }

    function testBurnFromSuccess() public {
        token.approve(address(actor), 200 * 10 ** 18);
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doBurnFrom(address,address,uint256)", token, owner, 200 * 10 ** 18)
        );
        Assert.ok(s, "bf");
        Assert.equal(token.balanceOf(owner), 800 * 10 ** 18, "bal");
        Assert.equal(token.totalSupply(), 800 * 10 ** 18, "sup");
    }

    function testBurnFromNoAllowance() public {
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doBurnFrom(address,address,uint256)", token, owner, 100 * 10 ** 18)
        );
        Assert.ok(!s, "bfNo");
    }

    function testBurnFromExceeds() public {
        token.approve(address(actor), 50 * 10 ** 18);
        (bool s, ) = address(actor).call(
            abi.encodeWithSignature("doBurnFrom(address,address,uint256)", token, owner, 100 * 10 ** 18)
        );
        Assert.ok(!s, "bfEx");
    }

    function testBurnFromZero() public {
        (bool s, ) = address(token).call(
            abi.encodeWithSignature("burnFrom(address,uint256)", address(0), 100 * 10 ** 18)
        );
        Assert.ok(!s, "bfZero");
    }
}