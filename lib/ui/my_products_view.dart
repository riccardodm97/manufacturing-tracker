import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/my_products_view_model.dart';
import 'package:dapp/ui/colors.dart';

class MyProductsView extends StatelessWidget {
  const MyProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyProductsViewModel>.reactive(
        viewModelBuilder: () => MyProductsViewModel(),
        onModelReady: (model) async => await model.getAllUserProducts(context),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  'My products',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                elevation: 10,
                backgroundColor: color1,
              ),
              body: Center(
                child: model.busy
                    ? const CircularProgressIndicator()
                    : model.userProducts.isNotEmpty
                        ? ListView.builder(
                            itemCount: model.userProducts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 24.0),
                                child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        model.navigateToProductView(
                                            context,
                                            model.userProducts.keys
                                                .toList()[index]);
                                      },
                                      title: Text(
                                          model.userProducts.values
                                              .toList()[index],
                                          style: const TextStyle(
                                              fontSize: 24.0, color: color1)),
                                      subtitle: Text(
                                          model.userProducts.keys
                                              .toList()[index],
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          )),
                                    ),
                                    color: color7),
                              );
                            })
                        : const Center(
                            child: Text('No products to show',
                                style:
                                    TextStyle(fontSize: 24.0, color: color1)),
                          ),
              ),
            ));
  }
}
