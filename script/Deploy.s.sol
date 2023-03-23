// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {DelegationRegistry} from "../src/delegateCash/DelegationRegistry.sol";

interface ImmutableCreate2Factory {
    function safeCreate2(bytes32 salt, bytes calldata initCode) external payable returns (address deploymentAddress);
    function findCreate2Address(bytes32 salt, bytes calldata initCode)
        external
        view
        returns (address deploymentAddress);
    function findCreate2AddressViaHash(bytes32 salt, bytes32 initCodeHash)
        external
        view
        returns (address deploymentAddress);
}

contract Deploy is Script {
    // https://ethereum.stackexchange.com/questions/30257/remix-warning-this-looks-like-an-address-but-has-an-invalid-checksum
    // 0x71C95911E9a5D330f4D621842EC243EE1343292e
    address create2Factory = 0x71C95911E9a5D330f4D621842EC243EE1343292e;
    ImmutableCreate2Factory immutable factory = ImmutableCreate2Factory(create2Factory);
    bytes initCode = type(DelegationRegistry).creationCode;
    bytes32 salt = 0x00000000000000000000000000000000000000008b99e5a778edb02572010000;

    function run() external {
        vm.startBroadcast();

        address registryAddress = factory.safeCreate2(salt, initCode);
        DelegationRegistry registry = DelegationRegistry(registryAddress);
        console2.log(address(registry));

        vm.stopBroadcast();
    }
}
