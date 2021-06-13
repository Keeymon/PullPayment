pragma solidity 0.8.0;

contract PullOverPush {

    mapping(address => uint) credits;

    function push() public payable {
        allowForPull(msg.sender, msg.value);
    }

    function allowForPull(address receiver, uint amount) private {
        credits[receiver] += amount;
    }

    function withdrawCredits() public {
        uint amount = credits[msg.sender];

        require(amount != 0);
        require(address(this).balance >= amount);

        credits[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }
}
