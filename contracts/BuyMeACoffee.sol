// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract BuyMeACoffee {

    event NewMemo (
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    address payable owner;


    

    Memo [] memos;

//Owner COnstructor
    constructor () {
        owner = payable(msg.sender);
    }

    //Modifier for the new Owner
   /**modifier new_Owner(){
        require (owner == msg.sender);
        _;
    }
    **/

//This function should allow transfer of ownership to buy coffee 
    function new_Owner_Sign(address new_Owner) public{
        require(new_Owner != address(0), "Invalid Address");
        owner = payable(new_Owner);
    }

    function getMemos() public view returns (Memo[] memory){
        return memos;
    }

    function buyCoffee(string memory _name, string memory _message) public payable {
        // Must accept more than 0 ETH for a coffee.
        require(msg.value > 0, "can't buy coffee for free!");

        // Add the memo to storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a NewMemo event with details about the memo.
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
}