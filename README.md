A simple ERC-20 token implemented on the Ethereum Sepolia testnet. This project demonstrates the core functionality of an ERC-20 token plus additional minting and burning capabilities, along with comprehensive unit tests.

Features
Standard ERC-20 functions: transfer, balanceOf, approve, transferFrom

Minting: Only the contract owner can create new tokens.

Burning: Any token holder can burn their own tokens (burn) or allow a third party to burn on their behalf (burnFrom after approval).

Ownable: The contract owner can be transferred.

Technologies Used
Solidity ^0.8.20

OpenZeppelin Contracts for secure, standard implementations (ERC20, ERC20Burnable, Ownable)

Remix IDE for development, testing, and deployment

Sepolia Testnet for deployment

MetaMask for transaction signing

Solidity Unit Testing (Remix built-in)

Contract Address (Sepolia)
Deployed at: 0x70f0F2cde4805EC8BAE92418469cA06a70ef9BBD
View on Sepolia Etherscan

Getting Started
Prerequisites
A web browser with Remix IDE access

MetaMask extension installed

Sepolia test ETH (get from a faucet like faucet.quicknode.com)

Deployment Steps
Open Remix IDE.

Create a new file MyToken.sol and paste the contract code.

In the Solidity Compiler tab, set the compiler version to 0.8.20 and EVM version to paris (to avoid compatibility issues with the PUSH0 opcode).

Compile the contract.

Switch to the Deploy & Run Transactions tab.

Select Injected Provider – MetaMask as the environment and connect to Sepolia.

Click Deploy. MetaMask will ask you to confirm the transaction.

After deployment, copy the contract address from the terminal or from MetaMask.

Interacting with the Contract
You can interact with the contract directly in Remix or via Etherscan after verifying the source code.

Basic Operations:

Check balance: Call balanceOf with your address.

Transfer tokens: Use transfer (from your account) to send tokens to another address.

Approve spending: Call approve to allow another address to spend tokens on your behalf.

TransferFrom: The approved spender can then call transferFrom to move tokens.

Mint (owner only): Call mint with a recipient address and amount.

Burn: Call burn to destroy your own tokens.

BurnFrom: After approval, a spender can call burnFrom to burn tokens from the approver's balance.

Testing
Unit tests are written in Solidity using Remix's built-in testing framework. The test file MyToken_test.sol covers:

Core ERC-20 functions (transfer, approve, transferFrom)

Minting and burning (including edge cases like zero amounts or insufficient balance)

Access control (only owner can mint)

Allowance and balance checks

To run the tests:

In Remix, switch to the Solidity Unit Testing plugin.

Load the directory containing your test file (e.g., ERC-20).

Ensure the Solidity compiler EVM version is still set to paris.

Click Run – all tests should pass.

The test file uses a helper contract Actor (defined in a separate file Actor.sol) to simulate calls from different addresses. This ensures that non‑owners cannot mint and that allowances work correctly, without interfering with the test runner's expectations.

Key Design Decisions
OpenZeppelin Libraries: Using audited, standard implementations reduces security risks and ensures compliance with the ERC-20 specification.

Owner-Only Minting: Prevents arbitrary inflation by restricting token creation to the contract owner.

Inclusion of burnFrom: Enables third‑party burning (e.g., for dApps or exchanges) after user approval, increasing flexibility.

EVM Version paris: Avoids compatibility issues with the PUSH0 opcode introduced in Solidity 0.8.20, allowing tests to run smoothly in Remix.

Separate Actor Contract: Simplifies testing of permissions by impersonating different users without complicating the test files.

License
This project is licensed under the MIT License – see the LICENSE file for details.
