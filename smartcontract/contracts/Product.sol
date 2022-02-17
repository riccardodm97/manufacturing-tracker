// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


contract Product {

    string private name;
    string private producer;
    string private production_location;
    uint256 private production_date;
    address[] private constitutens;

    bool private isCostituent = false;
    bool private isInitialized = false; 
    bool private isFinished = false;

    modifier notInitd(){
        require(!isInitialized, "contract is already initialized");
        _ ; 
    }

    modifier notUsed(){
        require(!isCostituent, "product already used as costituent");
        _ ; 
    }

    modifier notFinished(){
        require(!isFinished, "can't add constitutens to completed product");
        _ ; 
    }

    modifier Finished(){
        require(isFinished,"product should be completed");
        _ ; 
    }

    constructor(){
        name = "master";
        isInitialized = true;
    }


    function init(string calldata _name,  string calldata _producer, string calldata _prod_location, uint256 _prod_date) external notInitd {
        name = _name;
        producer = _producer;
        production_location = _prod_location;
        production_date = _prod_date;
        isInitialized = true; 
    }

    function useThis() external notUsed Finished{
        isCostituent = true ; 
    }

    function addConstituent(address product) external notFinished { 
        constitutens.push(product);
    }

    function finishProduct() external {
        isFinished = true;
    }


    // getters 

    function getName() external view returns(string memory){
        return name;
    }

    function getProducer() external view returns(string memory){
        return producer;
    }

    function getProductionLocation() external view returns(string memory){
        return production_location;
    }

    function getProductionDate() external view returns(uint256){
        return production_date;
    }

    function getConstituents() external view returns(address[] memory){
        return constitutens;
    }
    
}