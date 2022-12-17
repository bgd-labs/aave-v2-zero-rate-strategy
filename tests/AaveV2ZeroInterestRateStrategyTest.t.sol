// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {RENFILZeroStrategyPayload} from '../src/contracts/RENFILZeroStrategyPayload.sol';
import {AaveV2ZeroInterestRateStrategy} from '../src/contracts/AaveV2ZeroInterestRateStrategy.sol';

contract AaveV2ZeroInterestRateStrategyTest is Test {
  address public constant RENFIL = 0xD5147bc8e386d91Cc5DBE72099DAC6C9b99276F5;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16205270);
  }

  function testZeroStrategyActivation() public {
    address strategyRenFilBefore = AaveV2Ethereum
      .POOL
      .getReserveData(RENFIL)
      .interestRateStrategyAddress;

    AaveV2ZeroInterestRateStrategy zeroStrategy = new AaveV2ZeroInterestRateStrategy(
      AaveV2Ethereum.POOL_ADDRESSES_PROVIDER
    );
    RENFILZeroStrategyPayload proposalPayload = new RENFILZeroStrategyPayload(
      address(zeroStrategy)
    );

    address[] memory targets = new address[](1);
    targets[0] = address(proposalPayload);
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute()';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = '';
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;

    GovHelpers.SPropCreateParams memory propCreationParams = GovHelpers.SPropCreateParams({
      executor: GovHelpers.SHORT_EXECUTOR,
      targets: targets,
      values: values,
      signatures: signatures,
      calldatas: calldatas,
      withDelegatecalls: withDelegatecalls,
      ipfsHash: bytes32('') // Doesn't matter for testing
    });

    uint256 proposalId = GovHelpers.createProposal(vm, propCreationParams);

    GovHelpers.passVoteAndExecute(vm, proposalId);

    address strategyRenFilAfter = AaveV2Ethereum
      .POOL
      .getReserveData(RENFIL)
      .interestRateStrategyAddress;

    assertEq(strategyRenFilAfter, address(zeroStrategy));
  }
}
