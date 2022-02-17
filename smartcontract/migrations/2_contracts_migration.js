
const Product = artifacts.require("Product");
const ProductFactory = artifacts.require("ProductFactory"); 

module.exports = function (deployer){
    deployer.deploy(Product).then(() => deployer.deploy(ProductFactory, Product.address)); 
};