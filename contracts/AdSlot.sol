// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdSlot {

    address payable public immutable owner;  // Owner address is immutable and set at deployment
    address public currentBidder;
    uint public currentBid;
    string public currentAdText;  // Current ad text
    uint public feeBalance;  // Accumulated fee amount for owner withdrawal

    event NewBid(address indexed bidder, uint bidAmount, string adText);
    event Refund(address indexed previousBidder, uint refundAmount);
    event FeeCollected(uint feeAmount);

    /// @notice Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(address payable _owner) {
        owner = _owner;
    }

    function bid(string calldata adText) external payable {
        require(msg.value > currentBid, "Bid should be higher than current bid");

        uint previousBid = currentBid;
        uint fee = (msg.value * 10) / 100;
        uint refundAmount = (previousBid * 90) / 100;

        address previousBidder = currentBidder;
        if (previousBidder != address(0)) {
            payable(previousBidder).transfer(refundAmount);
            emit Refund(previousBidder, refundAmount);
        }

        feeBalance += fee;

        currentBidder = msg.sender;
        currentBid = msg.value;
        currentAdText = adText;

        emit NewBid(msg.sender, currentBid, adText);
    }

    /// @notice Function for the contract owner to withdraw accumulated fees
    function withdrawFees() external onlyOwner {
        uint feeAmount = feeBalance;
        require(feeAmount > 0, "No fees to withdraw");

        feeBalance = 0;
        owner.transfer(feeAmount);

        emit FeeCollected(feeAmount);
    }

    function getCurrentBidInfo() external view returns (address, uint, string memory) {
        return (currentBidder, currentBid, currentAdText);
    }
}
