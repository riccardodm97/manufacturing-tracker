import 'package:dapp/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class CreateProductViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final AuthService _authService = serviceLocator<AuthService>();

  final List<String> _selectedComponents = [];
  final List<String> _allUserComponents = [];

  List<String> get selectedComponents => _selectedComponents;
  List<String> get allUserComponents => _allUserComponents;

  void addToComponentsList(String productAddress) {
    _selectedComponents.add(productAddress);
  }

  Future<String> getProductName(String productAddress) async {
    await _productService.setCurrentProduct(productAddress);
    return await _productService.getName();
  }

  Future<void> getPossibleComponents() async {
    List<String> productList = await _productService
        .getUserProducts(_authService.userAddress.toString());
    allUserComponents.addAll(productList);
  }

  void saveNewProduct(String name, String manName, String location) async {
    _productService.clearCurrentProduct();

    //create the product with given fields
    var hash = await _productService.createProduct(name, manName, location,
        BigInt.parse('123')); //DateTime.now().toString()));

    String addr = await _productService.getNewProductAddress(hash);

    await _productService.addProductToUser(
        _authService.userAddress.toString(), addr);

    for (String c in _selectedComponents) {
      await _productService.setCurrentProduct(c);
      await _productService.markAsUsed();
      _productService.clearCurrentProduct();
    }

    await _productService.setCurrentProduct(addr);

    for (String c in _selectedComponents) {
      await _productService.addConstituent(c);
    }

    await _productService.markAsFinished();
    _productService.clearCurrentProduct();
  }
}
