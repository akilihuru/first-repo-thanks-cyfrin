// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    function deployFundMe() public returns (FundMe, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!
        (address priceFeed) = helperConfig.activeNetworkConfig();


        vm.startBroadcast();
        FundMe fundMe = new FundMe(priceFeed);
        vm.stopBroadcast();
        return (fundMe, helperConfig);
    }

    // 👇 tests expect only FundMe from run()
    function run() external returns (FundMe) {
        (FundMe fundMe, ) = deployFundMe(); // ignore HelperConfig with the comma
        return fundMe;
    }
}
