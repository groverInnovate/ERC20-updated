// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        console.log(msg.sender.balance);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        // This test is so suspicious, I hate it.
        // check it again
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowancesWork() public {
        uint256 initialAllowance = 1000;

        // Bob approves Alice to spend 1000 tokens.
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
    function testDecreaseAllowanceBelowZero() public {
        uint256 initialAllowance = 500;
        uint256 decreaseAmount = 1000;

        // Alice approves Bob to spend tokens on her behalf
        vm.prank(alice);
        ourToken.approve(bob, initialAllowance);

        // Alice tries to decrease the allowance below zero
        vm.prank(alice);
        vm.expectRevert();
        ourToken.transfer(bob, decreaseAmount);
    }


}