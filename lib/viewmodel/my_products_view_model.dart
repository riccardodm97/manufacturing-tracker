import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../service/auth_service.dart';
import '../setup/locator.dart';
import 'base_view_model.dart';

class MyProductsViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final AuthService _authService = serviceLocator<AuthService>();

  final Map<String, String> _userProducts = {};
  Map<String, String> get userProducts => _userProducts;

  Future<void> navigateToProductView(
          BuildContext context, String product) async =>
      await Navigator.pushNamed(context, '/product',
          arguments: [product, false]);

  Future<void> getAllUserProducts(context) async {
    _userProducts.clear();

    setBusy(true);
    List<String> constituents = await _productService
        .getUserProducts(_authService.userAddress.toString());

    for (String constituent in constituents) {
      await _productService.setCurrentProduct(constituent);
      _userProducts[constituent] = await _productService.getName();
      _productService.clearCurrentProduct();
    }
    setBusy(false);
    notifyListeners();
  }
}
