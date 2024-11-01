
# AdBidder

The **AdBidder** is a Web3-based smart contract project built on Hardhat, enabling users to bid for ad slots by depositing assets on the Ethereum blockchain. This repository consists of two primary contracts, `AdSlot` and `AdSlotFactory`, which manage the bidding functionality, fee collection, and contract creation.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Optimizations](#optimizations)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

This decentralized application (DApp) allows users to bid on specific ad slots, with the highest bidder's ad being displayed. If a new user outbids the current highest bidder, the previous highest bidder receives 90% of their original bid back, while the remaining 10% is accumulated as a fee for the contract owner.

The smart contracts are optimized for gas efficiency, with owner-only functions protected by Solidity's `modifier`. The project includes:
- **AdSlot**: A contract representing an individual ad slot.
- **AdSlotFactory**: A factory contract that creates and manages multiple `AdSlot` contracts.

## Features

- **Bidding System**: Users can bid on ad slots, and the highest bid determines which ad is displayed.
- **Fee Collection**: Each new bid deducts a 10% fee, which is stored for the contract owner.
- **Automatic Refunds**: When outbid, the previous highest bidder receives a 90% refund of their bid amount.
- **Owner-Only Functions**: Using a `modifier`, functions such as fee withdrawal are restricted to the contract owner.

## Optimizations

To ensure efficient gas usage, the following optimizations were implemented:
- **`immutable` Keyword**: The `owner` variable in each contract is set as `immutable`, minimizing state changes and gas costs.
- **`payable` Modifier**: `owner` is defined as `payable` to streamline Ether transfers without casting.
- **Efficient Storage Layout**: Grouped variables by size for optimized storage allocation.
- **Minimal State Updates**: The `feeBalance` variable is only updated when necessary, reducing storage write operations.
- **Event Logging Optimization**: Only essential information is logged in events, reducing storage costs on the blockchain.

## Installation

1. **Install Node.js**  
   Ensure you have [Node.js](https://nodejs.org/) installed. Node.js includes `npm`, which is required to install `yarn`.

2. **Install Yarn**  
   If you don’t have Yarn installed globally, you can add it using `npm`:

   ```bash
   npm install -g yarn
   ```

3. **Clone the Repository**
   ```bash
   git clone https://github.com/chain-chainger/ad-bidder.git
   cd ad-bidder
   ```

4. **Install Project Dependencies**  
   Install all dependencies (including Hardhat) with `yarn`:

   ```bash
   yarn install
   ```

5. **Compile Contracts**
   ```bash
   npx hardhat compile
   ```

## Usage

1. **Deploy Contracts**  
   Use Hardhat to deploy the contracts locally or to a testnet. Deployment scripts are provided in the `scripts` folder.
   
   ```bash
   npx hardhat run scripts/deploy.js --network localhost
   ```

2. **Interacting with Contracts**
   - **Creating Ad Slots**: The contract owner can create new ad slots using the `AdSlotFactory` contract.
   - **Bidding**: Users can bid on an ad slot by sending Ether along with their ad text.
   - **Withdraw Fees**: Only the owner can withdraw accumulated fees from each `AdSlot`.

3. **Testing**  
   Write and run tests with Hardhat to ensure the functionality works as expected. Test cases can be added in the `test` folder.

   ```bash
   npx hardhat test
   ```

## Example

Here is an example of how to bid on an ad slot and withdraw fees (in Solidity):

```solidity
// Assuming an AdSlot contract instance is available as adSlot
adSlot.bid{value: 1 ether}("Your Ad Text");

// Only the owner can withdraw accumulated fees
adSlot.withdrawFees();
```

## Contributing

Contributions are welcome! Please follow these steps to contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a Pull Request.

## License

This project is licensed under the MIT License.
