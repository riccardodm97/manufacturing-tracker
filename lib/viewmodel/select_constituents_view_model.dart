import 'package:dapp/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class SelectConstituentsViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final AuthService _authService = serviceLocator<AuthService>();

  final Map<String, String> _selectedConstituents = {};
  final Map<String, String> _possibleConstituents = {};

  Map<String, String> get selectedConstituents => _selectedConstituents;
  Map<String, String> get possibleConstituents => _possibleConstituents;

  void addToConstituentsMap(String productAddress) {
    _selectedConstituents[productAddress] =
        _possibleConstituents[productAddress]!;
    notifyListeners();
  }

  void removeFromConstituentsMap(String productAddress) {
    _selectedConstituents.remove(productAddress);
    notifyListeners();
  }

  Future<String> getProductName(String productAddress) async {
    await _productService.setCurrentProduct(productAddress);
    var name = await _productService.getName();
    _productService.clearCurrentProduct();
    return name;
  }

  Future<void> onStartup(context) async {
    _selectedConstituents.clear();
    _possibleConstituents.clear();

    setBusy(true);
    List<String> constituents = await _productService
        .getUserProducts(_authService.userAddress.toString());

    for (String constituent in constituents) {
      _possibleConstituents[constituent] = await getProductName(constituent);
    }
    setBusy(false);
  }

  Future<void> navigateBack(BuildContext context) async {
    Navigator.pop(context, _selectedConstituents);
  }
}
