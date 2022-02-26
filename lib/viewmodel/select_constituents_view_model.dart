import 'package:dapp/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class SelectConstituentsViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final AuthService _authService = serviceLocator<AuthService>();

  final List<String> _selectedConstituents = [];
  final List<String> _possibleConstituents = [];

  List<String> get selectedConstituents => _selectedConstituents;
  List<String> get possibleConstituents => _possibleConstituents;

  void addToConstituentsList(String productAddress) {
    _selectedConstituents.add(productAddress);
    notifyListeners();
  }

  void removeFromConstituentsList(String productAddress) {
    _selectedConstituents.remove(productAddress);
    notifyListeners();
  }

  Future<String> getProductName(String productAddress) async {
    await _productService.setCurrentProduct(productAddress);
    return await _productService.getName();
  }

  Future<void> onStartup(context) async {
    _selectedConstituents.clear();
    _possibleConstituents.clear();

    setBusy(true);
    try {
      List<String> constituents = await _productService
          .getUserProducts(_authService.userAddress.toString());
      _possibleConstituents.addAll(constituents);
    } catch (e) {
      showTextDialog(context, 'Warning', e.toString());
    }
    setBusy(false);
  }

  Future<void> navigateBack(BuildContext context) async {
    Navigator.pop(context, _selectedConstituents);
  }
}
