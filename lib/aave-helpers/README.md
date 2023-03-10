# BGD <> AAVE helpers

This package contains various contracts which allow you to streamline testing within the aave protocol in foundry.

## GovHelpers

These helpers allow you to create and execute proposals on L1 so you don't have to care about having enough proposition power, timings, etc.

## ProxyHelpers

These helpers allow you to fetch the current implementation & admin for a specified proxy.

## BridgeExecutorHelpers

These helpers allow you to simulate execution of proposals on governance controlled Aave V2/V3 pools.

## ProtocolV3TestBase

The ProtocolV3TestBase is intended to be used with proposals that alter a V3 pool. While the `helpers` are libraries, you can use from where ever you want `ProtocolV3TestBase` is intended to be inherited from in your test via `is ProtocolV3TestBase`.

When inheriting from `ProtocolV3TestBase` you have access to methods to create readable configuration snapshots of a pool and e2e tests of a pool.
