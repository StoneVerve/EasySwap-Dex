// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Tetra.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


/*
 * Keeps track of all the pairings created between Tetra token and an ERC20 token. It also keeps track
 * of the fixed rate between each couple
 */
contract Couple{
    
    // Tetra token address that we use to create couples to exchange Tetra tokens for other ERC20 tokens on EasySwap
    Tetra private coin;
    
    mapping (address => bool) public tokenCouples;
    mapping (address => uint256) public conversionRates;
    
    // Informs about the creation of a new Couple
    event CoupleCreated(address who, address token, uint256 rate);
    
    /*
     * We provide the address that corresponds to our token Tetra
     */
    constructor(Tetra coin_) {
        coin = coin_;
    }
    
    
    /*
     * Creats a new couple between the token Tetra and an ERC20 token that implements 
     * Openzeppelin's interace IERC20 with a fix rate between Tetra and the ERC20 token
     */
    function newCouple(address token, uint256 rate) public returns(bool){
        require(token != address(0), "Invalid address, The address corresponds to the address zero");
        require(token != address(coin), "You can't create a couple of Tetra with itself");
        require(!tokenCouples[token], "There is already a couple with the address provided");
        tokenCouples[token] = true;
        conversionRates[token] = rate;
        emit CoupleCreated(msg.sender, token, rate);
        return true;
    }
    
}