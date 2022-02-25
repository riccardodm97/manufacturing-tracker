import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dapp/ui_temp/product.dart';

class UploadViewModel extends ChangeNotifier {
  List<Product> products = [
    Product(name: 'Farina', date: '1/1/2001', id: 'abc'),
    Product(name: 'Acqua', date: '2/1/2001', id: 'def'),
    Product(name: 'Sale', date: '3/1/2001', id: 'ghi'),
    Product(name: 'Pomodoro', date: '4/1/2001', id: 'jkl'),
  ];

  List<String> getComponentsName(x) {
    List<String> output = [];
    for (final comp in x) {
      output.add(comp.name);
    }
    return output;
  }

  void addProduct(product) {
    products.add(product);
    notifyListeners();
  }

  // List<String> getProducts() {
  //   List<String> output = [];
  //   for (final prod in products) {
  //     output.add(prod.name);
  //   }
  //   return output;
  // }
}
