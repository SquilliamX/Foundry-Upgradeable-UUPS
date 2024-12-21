// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// Import all necessary contracts for testing
import { DeployBox } from "../script/DeployBox.s.sol"; // Script to deploy initial implementation
import { UpgradeBox } from "../script/UpgradeBox.s.sol"; // Script to upgrade to new implementation
import { Test, console } from "forge-std/Test.sol"; // Foundry testing framework
import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol"; // The proxy contract
import { BoxV1 } from "../src/BoxV1.sol"; // First implementation
import { BoxV2 } from "../src/BoxV2.sol"; // Second implementation

contract DeployAndUpgradeTest is Test {
    // Declare state variables for the test contract
    DeployBox public deployer; // Instance of deployment script
    UpgradeBox public upgrader; // Instance of upgrade script
    address public OWNER = makeAddr("owner"); // Create a test address labeled "owner"

    address public proxy; // Will store the proxy contract address

    function setUp() public {
        // Deploy fresh instances of our deployment and upgrade scripts
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        // Deploy BoxV1 and the proxy, store proxy address
        proxy = deployer.run(); // This deploys BoxV1 and ERC1967Proxy pointing to it
    }

    function testProxyStartsAsBoxV1() public {
        // Verify proxy starts with BoxV1 implementation by checking that BoxV2's
        // setNumber function doesn't exist yet (it should revert)
        vm.expectRevert();
        BoxV2(proxy).setNumber(7); // This should fail as setNumber isn't in V1
    }

    function testUpgrades() public {
        // Deploy a new BoxV2 implementation
        BoxV2 box2 = new BoxV2();

        // Upgrade the proxy to point to BoxV2
        upgrader.upgradeBox(proxy, address(box2));

        // Verify we're now on V2 by checking the version number
        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());

        // Verify V2 functionality works by using the new setNumber function
        BoxV2(proxy).setNumber(7);
        assertEq(7, BoxV2(proxy).getNumber()); // Verify number was set correctly
    }
}
