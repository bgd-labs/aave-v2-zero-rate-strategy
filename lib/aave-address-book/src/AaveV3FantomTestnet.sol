// SPDX-License-Identifier: MIT
// AUTOGENERATED - DON'T MANUALLY CHANGE
pragma solidity >=0.6.0;

import {IPoolAddressesProvider, IPool, IPoolConfigurator, IAaveOracle, IAaveProtocolDataProvider, IACLManager, ICollector} from "./AaveV3.sol";

library AaveV3FantomTestnet {
    IPoolAddressesProvider internal constant POOL_ADDRESSES_PROVIDER =
        IPoolAddressesProvider(0xE339D30cBa24C70dCCb82B234589E3C83249e658);

    IPool internal constant POOL =
        IPool(0x771A45a19cE333a19356694C5fc80c76fe9bc741);

    IPoolConfigurator internal constant POOL_CONFIGURATOR =
        IPoolConfigurator(0x59B84a6C943dD655D9E3B4024fC6AdC0E3f4Ff60);

    IAaveOracle internal constant ORACLE =
        IAaveOracle(0xA840C768f7143495790eC8dc2D5f32B71B6Dc113);

    IAaveProtocolDataProvider internal constant AAVE_PROTOCOL_DATA_PROVIDER =
        IAaveProtocolDataProvider(0xCbAcff915f2d10727844ab0f2A4D9768954981e4);

    IACLManager internal constant ACL_MANAGER =
        IACLManager(0x94f154aba287b3024fb32386463FC52d488bb09B);

    address internal constant ACL_ADMIN =
        0x77c45699A715A64A7a7796d5CEe884cf617D5254;

    address internal constant COLLECTOR =
        0xF49dA7a22463D140f9f8dc7C91468C8721215496;

    ICollector internal constant COLLECTOR_CONTROLLER =
        ICollector(0x7aaB2c2CC186131851d6B1876D16eDc849846042);

    address internal constant DEFAULT_INCENTIVES_CONTROLLER =
        0x54Bc1D59873A5ABde98cf76B6EcF4075ff65d685;

    address internal constant DEFAULT_A_TOKEN_IMPL_REV_1 =
        0xFc1Ab0379db4B6ad8Bf5Bc1382e108a341E2EaBb;

    address internal constant DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1 =
        0x981D8AcaF6af3a46785e7741d22fBE81B25Ebf1e;

    address internal constant DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1 =
        0xc048C1b6ac47393F073dA2b3d5D1cc43b94891Fd;

    address internal constant EMISSION_MANAGER =
        0x0000000000000000000000000000000000000000;
}
