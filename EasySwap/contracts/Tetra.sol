// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";




/*
 * ERC20 token to exchange for other ERC20 tokens or ether on EasySwap
 */
contract Tetra is ERC20 {

    address public theMinter;
    
    event MinterPassed(address indexed oldMinter, address newMinter);
    
    
    /*
     * We keep track of the contract that will own all the coins after minting 
     * all the Tetra tokens
     */
    constructor() payable ERC20("Tetra", "TET"){
        theMinter = msg.sender;
    }
    
    
    /*
     * Passes the role of minter to a new adress. Only the current minter can pass role to 
     * another adress
     */
    function passMinter(address newMinter) public returns(bool) {
        require(msg.sender == theMinter, "You are not allowed to the pass the minter role");
        theMinter = newMinter;
        
        emit MinterPassed(msg.sender, theMinter);
        return true;
    }
    
    /*
     * Auxilary function to mint all the fixed supply of the Tetra token.
     * Can only be call by the minter to mint the total supply of one million Tetra tokens
     */
    function mint(address account) public{
        require(msg.sender == theMinter, "You are not allowed to mint new tokens");
        require(this.totalSupply() == 0, "All the coins have been minted");
        _mint(account, 1000000000000000000000000);
    }
    
}