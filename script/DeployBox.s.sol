// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

// Import required contracts
import { Script } from "forge-std/Script.sol";
import { BoxV1 } from "src/BoxV1.sol";
import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    // Main entry point for the deployment script
    function run() external returns (address) {
        // Call the deployment function and return the proxy address
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        // Step 1: Deploy the implementation contract (BoxV1)
        // This contains the actual logic but should never be used directly
        BoxV1 box = new BoxV1();

        // Step 2: Deploy the ERC1967Proxy contract
        // - First parameter (address(Box)): Points to the implementation contract
        // - Second parameter (""): Empty bytes for initialization data
        //   Note: We could pass initialize() function call here, but in this case we'll call it separately
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        // The ERC1967Proxy is the actual proxy contract that users will interact with, and it delegates calls to your implementation contracts (BoxV1 first, and later can be upgraded to Boxv2).

        vm.stopBroadcast();

        // Return the address of the proxy contract
        // This is the address users will interact with
        return address(proxy);
    }
}
