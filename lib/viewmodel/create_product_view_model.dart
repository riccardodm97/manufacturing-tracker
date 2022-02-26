import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class CreateProductViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();

  final List<String> _componentsList = [];

  void openComponentsPopup(BuildContext context) async {
    throw UnimplementedError();
  }

  void getPossibleComponents() async {}

  void saveNewProduct(String name, String manName, String date) {}
}
