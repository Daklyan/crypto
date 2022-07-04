pragma solidity 0.5.16;

import "hardhat/console.sol";

contract kickstarterLidl {
    string private name;
    address payable private crowdfundAddress;
    address private owner;
    uint private closingDate;

    event SendEthereum(uint256 value, address sender);

    constructor(string memory crowdfundName, uint closingDate) public {
        require(bytes(crowdfundName).length > 0);
        require(closingDate > now);
        name = crowdfundName;
        closingDate = closingDate;
        owner = msg.sender;
        crowdfundAddress = address(uint160(address(this)));
    }

    function transferToOwner() public {
        require(msg.sender == owner && now > closingDate);
        address(msg.sender).send(getMoney());
    }

    function send() external payable {
        require(closingDate > now);
        address(crowdfundAddress).send(msg.value);
        emit SendEthereum(msg.value, msg.sender);
    }

    function getBalance() public view returns (uint256 retVal) {
        return crowdfundAddress.balance;
    }

    function getEndDate() public view returns (uint endDate) {
        return closingDate;
    }

    function getName() public view returns (string memory retName) {
        return name;
    }
}