// SPDX-License-Identifier: MIT
pragma solidity >=0.7.3;
pragma experimental ABIEncoderV2;

contract LifeMilestones {

    address public owner;
    string public milestone;

    string public name1;
    string public name2;
    string public location;
    string public date;

    event MilestoneUpdated(string milestone);
    event DetailedMilestoneUpdated(string milestone, string[] participants, string location, uint256 date);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(
        address _owner,
        string memory _name1,
        string memory _name2,
        string memory _location,
        string memory _date,
        string memory initialMilestone
    ) {
        owner = _owner;
        name1 = _name1;
        name2 = _name2;
        location = _location;
        date = _date;

        _updateMilestone(initialMilestone);
    }

    function updateMilestone(string calldata newMilestone) external onlyOwner {
        _updateMilestone(newMilestone);
    }

    function updateDetailedMilestone(
        string calldata newMilestone,
        string[] calldata participants,
        string calldata eventLocation,
        uint256 eventDate
    ) external onlyOwner {
        milestone = newMilestone;
        emit DetailedMilestoneUpdated(milestone, participants, eventLocation, eventDate);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New owner cannot be the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function _updateMilestone(string memory newMilestone) internal {
        milestone = newMilestone;
        emit MilestoneUpdated(milestone);
    }
}