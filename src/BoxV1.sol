// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// first version of the implementation contract before the upgrade
contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    // example
    uint256 internal number;

    /// @custom:oz-upgrades-unsafe-allow constructor // this comment turns off the warning/error of using a constructor in the proxy.
    constructor() {
        _disableInitializers(); // constructors are not used in upgradeable contracts. this is best practice to prevent initializers from happening in the constructor
    }

    // intialize function is essentially a constuctor for proxies/implementations/upgrades
    // initializer modifier makes it so that this initialize function can only be called once
    function initialize() public initializer {
        // upgradeable intializer functions should start with double underscores `__`
        __Ownable_init(); // sets owner to: owner = msg.sender
        __UUPSUpgradeable_init(); // best practice to have to show this is a UUPS upgradeable contract
    }

    // example
    function getNumber() external view returns (uint256) {
        return number;
    }

    // example
    function version() external pure returns (uint256) {
        return 1;
    }

    // we need to override this function a use it
    function _authorizeUpgrade(address newImplementation) internal override { }
}
