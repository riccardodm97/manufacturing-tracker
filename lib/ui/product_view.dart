import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/product_view_model.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List;
    return ViewModelBuilder<ProductViewModel>.nonReactive(
        viewModelBuilder: () => ProductViewModel(arguments[0], arguments[1]),
        builder: (context, model, child) => Scaffold(
                appBar: AppBar(
              title: const Text('Product'),
              backgroundColor: Colors.grey[900],
            )));
  }
}
