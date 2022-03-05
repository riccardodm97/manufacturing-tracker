// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


contract Product {

    string private name;
    address private manufacturer_address;
    string private manufacturer_name; 
    string private production_location;
    string private production_date;
    address[] private constituens;

    bool private isCostituent = false;
    bool private isInitialized = false; 
    bool private isFinished = false;

    address private owner;

    event OwnershipTransferred(address old_owner, address new_owner);

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


    function init(address _owner, string calldata _name, string calldata _manufacturer_name, string calldata _prod_location, string calldata _prod_date) external notInitd {
        name = _name;
        manufacturer_name = _manufacturer_name;
        manufacturer_address = _owner;
        production_location = _prod_location;
        production_date = _prod_date;
        owner = _owner;
        isInitialized = true; 
    }

    function addConstituent(address product) external onlyOwner notFinished { 
        constituens.push(product);
    }

    function transferOwnership() external finished notUsed{
        address old_owner = owner;
        owner = msg.sender;

        emit OwnershipTransferred(old_owner, owner);
    }

    function markAsUsed() external onlyOwner finished notUsed{
        isCostituent = true;
    }

    function markAsFinished() external onlyOwner {
        isFinished = true;
    }

    
    // getters 

    function getProductDetails() external view returns(string memory, address, string memory, string memory, string memory){
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

    function getProductionDate() external view returns(string memory){
        return production_date;
    }

    function getConstituents() external view returns(address[] memory){
        return constituens;
    }
    
}