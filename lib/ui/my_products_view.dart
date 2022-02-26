import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/my_products_view_model.dart';

class MyProductsView extends StatelessWidget {
  const MyProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyProductsViewModel>.nonReactive(
        viewModelBuilder: () => MyProductsViewModel(),
        builder: (context, model, child) => Scaffold(
                appBar: AppBar(
              title: const Text('My Products'),
              backgroundColor: Colors.grey[900],
            )));
  }
}
