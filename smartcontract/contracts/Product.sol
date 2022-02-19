// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


contract Product {

    string private name;
    address private manufacturer_address;
    string private manufacturer_name; 
    string private production_location;
    uint256 private production_date;
    address[] private constitutens;

    bool private isCostituent = false;
    bool private isInitialized = false; 
    bool private isFinished = false;

    address private owner;

    modifier onlyOwner(){
        require(msg.sender == owner, "you are not the owner of this contract");
        _;
    }

    modifier notInitd(){
        require(!isInitialized, "contract is already initialized");
        _; 
    }

    modifier notUsed(){
        require(!isCostituent, "product already used as costituent");
        _; 
    }

    modifier notFinished(){
        require(!isFinished, "can't add constitutens to completed product");
        _; 
    }

    modifier finished(){
        require(isFinished, "product should be finished");
        _; 
    }

    constructor(){
        name = "master";
        isInitialized = true;
    }


    function init(string calldata _name, string calldata _manufacturer_name, string calldata _prod_location, uint256 _prod_date, address _owner) external notInitd {
        name = _name;
        manufacturer_name = _manufacturer_name;
        manufacturer_address = _owner;
        production_location = _prod_location;
        production_date = _prod_date;
        owner = _owner;
        isInitialized = true; 
    }

    function addConstituent(address product) external onlyOwner notFinished { 
        constitutens.push(product);
    }

    function tranfer(address _new_owner) external finished {
        owner = _new_owner;
    }

    function markAsUsed() external onlyOwner finished notUsed{
        isCostituent = true;
    }

    function markAsFinished() external onlyOwner {
        isFinished = true;
    }

    
    // getters 

    function getProductDetails() external view returns(string memory, address, string memory, string memory, uint256){
        return (name,manufacturer_address,manufacturer_name,production_location,production_date);
    }

    function getName() external view returns(string memory){
        return name;
    }

    function getManufacturer() external view returns(address, string memory){
        return (manufacturer_address, manufacturer_name);
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