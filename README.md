# MyToken (MTK)

A simple ERC-20 token implemented on the Ethereum Sepolia testnet. This project demonstrates the core functionality of an ERC-20 token plus additional minting and burning capabilities, along with comprehensive unit tests.

## Tools

* Solidity `^0.8.20`
* OpenZeppelin 
* Remix IDE
* MetaMask
* Sepolia Testnet

## Deployment (Remix)

1. Open [https://remix.ethereum.org/](https://remix.ethereum.org/)
2. Upload the contracts.
3. Compiler: `0.8.20`
4. EVM Version: `paris`
5. Deploy using **Injected Provider – MetaMask** (connected to Sepolia).
6. Confirm transaction.

## Contract

**Address:**

```
0x70f0F2cde4805EC8BAE92418469cA06a70ef9BBD
```

View on Etherscan:
[https://sepolia.etherscan.io/address/0x70f0F2cde4805EC8BAE92418469cA06a70ef9BBD](https://sepolia.etherscan.io/address/0x70f0F2cde4805EC8BAE92418469cA06a70ef9BBD)

## Basic Operations

- **Check Balance**  
  Call `balanceOf(address)` with your wallet address.

- **Transfer Tokens**  
  Use `transfer(to, amount)` to send tokens to another address.

- **Approve Spending**  
  Call `approve(spender, amount)` to allow another address to spend tokens on your behalf.

- **Transfer From (Allowance)**  
  The approved address can call `transferFrom(from, to, amount)` to move tokens.

- **Mint (Owner Only)**  
  Call `mint(to, amount)` to create new tokens. Only the contract owner can execute this.

- **Burn**  
  Call `burn(amount)` to destroy your own tokens.

- **Burn From**  
  After approval, a spender can call `burnFrom(from, amount)` to burn tokens from another account.


## Testing

* Run the **Solidity Unit Testing** plugin in Remix.
* Include `MyToken.sol` .
* Ensure compiler `0.8.20` and EVM `paris`.

## Acknowledgments

OpenZeppelin for secure contract libraries (https://openzeppelin.com/)

Remix IDE for development and testing (https://remix.ethereum.org/)

Sepolia Testnet for deployment (https://sepolia.dev/)
