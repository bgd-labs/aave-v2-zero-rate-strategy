// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

import {AaveV2ZeroInterestRateStrategy} from '../src/contracts/AaveV2ZeroInterestRateStrategy.sol';
import {RENFILZeroStrategyPayload} from '../src/contracts/RENFILZeroStrategyPayload.sol';

contract DeployZeroStrategy is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV2ZeroInterestRateStrategy(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER);
    vm.stopBroadcast();
  }
}

contract DeployProposalPayload is Script {
  function run() external {
    vm.startBroadcast();
    new RENFILZeroStrategyPayload(0x311C866D55456e465e314A3E9830276B438A73f0);
    vm.stopBroadcast();
  }
}

library DeployL1Proposal {
  struct Execution {
    address target;
    string signature;
    bytes callData;
  }

  function _deployL1Proposal(Execution[] memory executions, bytes32 ipfsHash)
    internal
    returns (uint256 proposalId)
  {
    require(ipfsHash != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");
    address[] memory targets = new address[](executions.length);
    uint256[] memory values = new uint256[](executions.length);
    string[] memory signatures = new string[](executions.length);
    bytes[] memory calldatas = new bytes[](executions.length);
    bool[] memory withDelegatecalls = new bool[](executions.length);

    for (uint256 i = 0; i < executions.length; i++) {
      targets[i] = executions[i].target;
      values[i] = 0;
      signatures[i] = executions[i].signature;
      calldatas[i] = executions[i].callData;
      withDelegatecalls[i] = true;
    }

    return
      AaveGovernanceV2.GOV.create(
        IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
        targets,
        values,
        signatures,
        calldatas,
        withDelegatecalls,
        ipfsHash
      );
  }
}

contract CreateGovProposal is Script {
  address internal constant ZERO_RATE_PAYLOAD = 0xBFcF7a2D4A91e91c72cdcf07eC65de6bF507DaAb;

  bytes32 internal constant IPFS_HASH =
    0x6e0d5a583e556e7bd8d1b9e3456b34ac085539320e248446792ea3600af12af0;

  function run() external {
    DeployL1Proposal.Execution[] memory executions = new DeployL1Proposal.Execution[](1);
    executions[0] = DeployL1Proposal.Execution({
      target: ZERO_RATE_PAYLOAD,
      signature: 'execute()',
      callData: ''
    });

    vm.startBroadcast();
    DeployL1Proposal._deployL1Proposal(executions, IPFS_HASH);
    vm.stopBroadcast();
  }
}
