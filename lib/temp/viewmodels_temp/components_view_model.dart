import 'package:flutter/material.dart';

import '../ui_temp/product.dart';

class ComponentsViewModel extends ChangeNotifier {
  List<Product> products = [
    Product(name: 'Farina', date: '1/1/2001', id: 'abc'),
    Product(name: 'Acqua', date: '2/1/2001', id: 'def'),
    Product(name: 'Sale', date: '3/1/2001', id: 'ghi'),
    Product(name: 'Pomodoro', date: '4/1/2001', id: 'jkl'),
  ];

  List<Product> components = [];

  void getComponents(index) {
    components.add(products[index]);
    notifyListeners();
  }
}