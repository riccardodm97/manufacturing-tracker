import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../service/product_service.dart';
import '../service/auth_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class CreateProductViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final AuthService _authService = serviceLocator<AuthService>();

  Map<String, String> _selectedConstituents = {};

  Map<String, String> get selectedConstituents => _selectedConstituents;

  Future<void> navigateToSelectConstituentsView(BuildContext context) async {
    _selectedConstituents =
        await Navigator.pushNamed(context, '/selectConstituents')
            .then((value) => value as Map<String, String>);
    notifyListeners();
  }

  void navigateBack(BuildContext context) {
    _selectedConstituents.clear();
    Navigator.pop(context);
  }

  Future<void> saveNewProduct(String name, String manName, String location,
      BuildContext context) async {
    if (name == "" || manName == "" || location == "") {
      showTextDialog(
          context, true, 'Alert', 'One of the text fields are empty', null);
    } else {
      setBusy(true);
      _productService.clearCurrentProduct();

      //create the product with given fields
      var hash = await _productService.createProduct(
          name, manName, location, DateFormat.yMMMd().format(DateTime.now()));

      //get its new address
      String addr = await _productService.getNewProductAddress(hash);

      //add this product to the current user
      await _productService.addProductToUser(
          _authService.userAddress.toString(), addr);

      //remove all its constituents from the current user
      await _productService.removeProductFromUser(
          _authService.userAddress.toString(),
          selectedConstituents.keys.toList());

      //for each constituent, mark it as used
      for (String c in selectedConstituents.keys) {
        await _productService.setCurrentProduct(c);
        await _productService.markAsUsed();
        _productService.clearCurrentProduct();
      }

      await _productService.setCurrentProduct(addr);

      // add every constitutent to the product
      for (String c in selectedConstituents.keys) {
        await _productService.addConstituent(c);
      }

      //mark the product as finished
      await _productService.markAsFinished();
      _productService.clearCurrentProduct();
      setBusy(false);

      showTextDialog(context, false, 'Testo1', 'Testo2', [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
            child: const Text('OK'))
      ]);
    }
  }
}
