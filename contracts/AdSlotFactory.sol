// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AdSlot.sol";

contract AdSlotFactory {

    address public immutable owner;  // Owner address is immutable and set at deployment
    AdSlot[] public adSlots;  // List of created AdSlot contracts

    event AdSlotCreated(address indexed adSlotAddress, uint indexed slotId);

    /// @notice Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Creates a new ad slot
    function createAdSlot() external onlyOwner {
        AdSlot newAdSlot = new AdSlot(payable(owner));
        adSlots.push(newAdSlot);

        emit AdSlotCreated(address(newAdSlot), adSlots.length - 1);
    }

    /// @notice Get the address of a specific ad slot contract
    /// @param slotId The ID of the ad slot
    /// @return The address of the ad slot contract
    function getAdSlot(uint slotId) external view returns (address) {
        require(slotId < adSlots.length, "Invalid slot ID");
        return address(adSlots[slotId]);
    }

    /// @notice Retrieve all ad slot contract addresses
    /// @return An array of addresses of all created ad slot contracts
    function getAllAdSlots() external view returns (address[] memory) {
        uint adSlotCount = adSlots.length;
        address[] memory adSlotAddresses = new address[](adSlotCount);

        for (uint i = 0; i < adSlotCount; i++) {
            adSlotAddresses[i] = address(adSlots[i]);
        }
        return adSlotAddresses;
    }
}
