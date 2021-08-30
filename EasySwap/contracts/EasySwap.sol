// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Tetra.sol";
import "./Couple.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


/*
 * EasySwap allows users to swap any ERC20 token the implements the interface
 * IERC20 from Oppenzeppelin for the token Tetra at a fixes rate
 * EasySwap also allows to swap ether for Tetra at a fixed rate
 */
contract EasySwap{
    
    // Tetra token address that we use to create couples to exchange Tetra tokens for other ERC20 tokens on EasySwap
    Tetra private tetraToken;
    
    // Keeps track of all the couples created and their exchange rates 
    Couple private couples;
    
    // Et/Tetra exchange fixes rate
    uint256 public ethRate;
    
    event PurchasedToken(address who, uint256 amount, uint256 rate);
    
    /*
     * We provide the address that corresponds to our token Tetra
     */
    constructor(Tetra tToken, Couple coupleTracker, uint256 rate) {
        tetraToken = tToken;
        couples = coupleTracker;
        if(rate == 0) {
            //Default rate of 100 if no rate is provided when calling the constructor
            ethRate = 100;
        } else {
            ethRate = rate;
        }
    }
    
    
    function initialMinting() public {
        tetraToken.mint(address(this));
    }
    
    function buyTokens() public payable {
        uint256 totalAmount = msg.value * ethRate;
        require(tetraToken.balanceOf(address(this)) >= totalAmount);
        tetraToken.transfer(msg.sender, totalAmount);
        emit PurchasedToken(msg.sender, totalAmount, ethRate);
    }
    
    
    function sellTokens(uint256 amount) public {
        
    }
    
    
    function swapToTetra(address token) public {
        
    }
    
    function swapFromTetra(address token) public {
        
    }
    
   
}