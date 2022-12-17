// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

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
    new RENFILZeroStrategyPayload(address(0)); // TODO add strategy address
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
  address internal constant ZERO_RATE_PAYLOAD = address(0); // TODO

  bytes32 internal constant IPFS_HASH = bytes32(0); // TODO

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
