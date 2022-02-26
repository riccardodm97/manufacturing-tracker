import 'package:dapp/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class CreateProductViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final AuthService _authService = serviceLocator<AuthService>();

  List<String> _selectedComponents = [];

  List<String> get selectedComponents => _selectedComponents;

  Future<void> navigateToSelectComponentsView(BuildContext context) async {
    _selectedComponents =
        await Navigator.pushNamed(context, '/selectComponents')
            .then((value) => value as List<String>);
    notifyListeners();
  }

  void navigateBack(BuildContext context) {
    _selectedComponents.clear();
    Navigator.pop(context);
  }

  Future<void> saveNewProduct(String name, String manName, String location,
      BuildContext context) async {
    setBusy(true);
    _productService.clearCurrentProduct();

    //create the product with given fields
    var hash = await _productService.createProduct(name, manName, location,
        BigInt.parse('123')); //DateTime.now().toString()));

    String addr = await _productService.getNewProductAddress(hash);

    await _productService.addProductToUser(
        _authService.userAddress.toString(), addr);

    for (String c in selectedComponents) {
      await _productService.setCurrentProduct(c);
      await _productService.markAsUsed();
      _productService.clearCurrentProduct();
    }

    await _productService.setCurrentProduct(addr);

    for (String c in selectedComponents) {
      await _productService.addConstituent(c);
    }

    await _productService.markAsFinished();
    _productService.clearCurrentProduct();
    setBusy(false);

    navigateBack(context);
  }
}
