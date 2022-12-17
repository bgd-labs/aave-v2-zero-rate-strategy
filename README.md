# Aave v2. Zero interest rate strategy

Implementation of an interest rate strategy with all parameters zeroed.


<br>

## Can it cause any problem in the Aave v2 Ethereum pool?

No, it can't.

### Variable borrow rate

`reserve.currentVariableBorrowRate` gets used mainly in 2 internal functions of the protocol:
1. `_updateIndexes()`. Once the `reserve.currentVariableBorrowRate` on storage gets updated to 0, this will cause a multiplication by 0, making `cumulatedVariableBorrowInterest == 0`, and the variable borrow index to not change. **CORRECT**.
2. `getNormalizedDebt()`. This function returns a new "dynamics" variable debt index, adding the accrued growth since last update, based on time and the variable rate. As rate will be now 0, the effect will be that index will remain the same as before. Used by `getReserveNormalizedVariableDebt()`, that in turn gets used by `balanceOf()` and `totalSupply()` of the variable debt token. The final effect is that balances and supply of variable debt will be multiplied by the last updated index, not causing any growth, as expected. **CORRECT**.

### Stable borrow rate

The effect is the same as with variable debt, no problem happens, apart from the high-level economical impact of allowing an user to borrow at stable rate locking a 0 rate, which should probably be avoided.
Furthermore, renFIL doesn't have stable rate mode enabled, so no impact

<br>

## Setup

```sh
cp .env.example .env
forge install
```

## Test

```sh
make test
```
