import 'package:dapp/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class SelectComponentsViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final AuthService _authService = serviceLocator<AuthService>();

  final List<String> _selectedComponents = [];
  final List<String> _possibleComponents = [];

  List<String> get selectedComponents => _selectedComponents;
  List<String> get possibleComponents => _possibleComponents;

  void addToComponentsList(String productAddress) {
    _selectedComponents.add(productAddress);
  }

  void removeFromComponentsList(String productAddress) {
    _selectedComponents.remove(productAddress);
  }

  Future<String> getProductName(String productAddress) async {
    await _productService.setCurrentProduct(productAddress);
    return await _productService.getName();
  }

  Future<void> onStartup() async {
    _selectedComponents.clear();
    _possibleComponents.clear();

    setBusy(true);
    List<String> components = await _productService
        .getUserProducts(_authService.userAddress.toString());
    _possibleComponents.addAll(components);
    setBusy(false);
  }

  void navigateBack(BuildContext context) async {
    Navigator.pop(context, _selectedComponents);
  }
}
