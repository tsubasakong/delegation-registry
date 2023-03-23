// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import { ImmutableCreate2Factory } from 'src/create2/ImmutableCreate2Factory.sol';

contract Create2 is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new ImmutableCreate2Factory();
    }
}