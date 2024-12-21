// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

// Import required contracts and tools
import { Script } from "forge-std/Script.sol";
import { BoxV1 } from "src/BoxV1.sol"; // Original implementation
import { BoxV2 } from "src/BoxV2.sol"; // New implementation to upgrade to
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol"; // Helper for finding deployed contracts

contract UpgradeBox is Script {
    function run() external returns (address) {
        // Get the address of the most recently deployed proxy contract
        // DevOpsTools searches broadcast logs to find the ERC1967Proxy deployment
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        // Deploy the new implementation contract (BoxV2)
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();

        // Upgrade the proxy to point to the new implementation
        // This keeps the same proxy address but changes the logic contract
        address proxy = upgradeBox(mostRecentlyDeployed, address(newBox));
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        // Cast the proxy to BoxV1 to access the upgrade function
        // We use BoxV1 type because it has the UUPS upgrade interface we need
        BoxV1 proxy = BoxV1(proxyAddress);

        // Call upgradeTo() which is inherited from UUPSUpgradeable
        // This changes the implementation address in the proxy's storage
        proxy.upgradeTo(address(newBox)); // proxy contract now points to this new address
        vm.stopBroadcast();

        // Return the proxy address (which hasn't changed)
        return address(proxy);
    }
}
