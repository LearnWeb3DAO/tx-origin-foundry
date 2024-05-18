// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Good} from "../src/Good.sol";
import {Attack} from "../src/Attack.sol";

contract CounterTest is Test {
    //get one address
    address address1 = vm.addr(1);

    //variables to hold instances of our contracts
    Good public goodContract;
    Attack public attackContract;

    function setUp() public {
        //impersonate address1 and deploy the Good Contract
        vm.prank(address1);
        goodContract = new Good();

        // Deploy the Attack Contract
        attackContract = new Attack(address(goodContract));
    }

    function test_Attack() public {
        // Sets the next call's msg.sender to be the input address,
        // and the tx.origin to be the second input
        vm.prank(address1, address1);

        // Execute the attack
        attackContract.attack();

        // Now let's check if the current owner of the Good Contract is actually the Attack Contract
        assertEq(goodContract.owner(), address(attackContract));
    }
}
