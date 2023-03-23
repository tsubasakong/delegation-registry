# delegate wallet
For integrate with ip3 marketplace contracts (test purpose only).
- support `warm` and `delegateCash`.

## deploy on localhost network

Prerequiste: 
Start the local EVM envs in the `ip3-smart-contract` directory with command `npx hardhat node`. Then at terminal it will show series of accounts, for example:
```
Account #0: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (10000 ETH)
Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```
Then use this `Account #0` with the `Private Key` to run the following scripts to deploy contracts.
### DelegateCashDeploy

Deploy create2 contract:
```
forge script script/Create2.s.sol:Create2 --fork-url http://localhost:8545 \
--private-key 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d --broadcast
```

Then, get the create2 contract address from ouput, then input this address into file L23 of `script/Deploy.s.sol`.


Then deploy the delegateCash contract with command
```
forge script script/Deploy.s.sol:Deploy --fork-url http://localhost:8545 \
--private-key 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d --broadcast
```


## [DelegateCash] How do I use it?

Check out the [IDelegationRegistry.sol](src/IDelegationRegistry.sol) file. This is the interface to interact with, and contains the following methods:

```code
/// WRITE ///
function delegateForAll(address delegate, bool value) external;
function delegateForContract(address delegate, address contract_, bool value) external;
function delegateForToken(address delegate, address contract_, uint256 tokenId, bool value) external;
function revokeAllDelegates() external;
function revokeDelegate(address delegate) external;
function revokeSelf(address vault) external;
/// READ ///
function getDelegationsByDelegate(address delegate) external view returns (DelegationInfo[] memory);
function getDelegatesForAll(address vault) external view returns (address[] memory);
function getDelegatesForContract(address vault, address contract_) external view returns (address[] memory);
function getDelegatesForToken(address vault, address contract_, uint256 tokenId) external view returns (address[] memory);
function checkDelegateForAll(address delegate, address vault) external view returns (bool);
function checkDelegateForContract(address delegate, address vault, address contract_) external view returns (bool);
function checkDelegateForToken(address delegate, address vault, address contract_, uint256 tokenId) external view returns (bool);
```

As an NFT creator, the important ones to pay attention to are `getDelegationsByDelegate()`, which you can use on the website frontend to enumerate which vaults a specific hotwallet is delegated to act on behalf of, and `checkDelegateForToken()`, which can be called in your smart contract to ensure a hotwallet is acting on behalf of the proper vaults.
