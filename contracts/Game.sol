// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Game {
    constructor() payable {}
    /**
        Randomly picks a number out of `0 to 2²⁵⁶–1`.
    */
   function pickACard() private view returns(uint) {

   // keccak256 is a hashing function which takes in a bytes array and converts it into a bytes32 
   uint pickedCard = uint(keccak256(abi.encodePacked(blockhash(block.number), block.timestamp)));
   return pickedCard;

   }

   /** 
      It begins the game by first choosing a random number by calling `pickACard`
      It then verifies if the random number selected is equal to `_guess` passed by the player
      If the player guessed the correct number, it sends the player `0.1 ether`
   */

    function guess(uint _guess) public {
        uint _pickedCard = pickACard();
        if(_guess == _pickedCard){
            (bool sent,) = msg.sender.call{value: 0.1 ether}("");
            require(sent, "Failed to send ether");
        }
    }

    /** 
      Returns the balance of ether in the contract
    */
   function getBalance() view public returns(uint) {
    return address(this).balance;

   }
} 