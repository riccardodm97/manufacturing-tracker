import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/my_products_view_model.dart';

class MyProductsView extends StatelessWidget {
  const MyProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyProductsViewModel>.reactive(
        viewModelBuilder: () => MyProductsViewModel(),
        onModelReady: (model) async => await model.getAllUserProducts(context),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text('My Products'),
                backgroundColor: Colors.grey[900],
              ),
              body: Container(
                color: Colors.grey[800],
                child: Center(
                  child: model.busy
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: model.userProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 24.0),
                              child: Card(
                                  child: ListTile(
                                      onTap: () {
                                        model.navigateToProductView(
                                            context, model.userProducts[index]);
                                      },
                                      title: Text(model.userProducts[index],
                                          style:
                                              const TextStyle(fontSize: 24.0)),
                                      leading: const CircleAvatar(
                                          child: Icon(
                                              Icons.bookmark_border_outlined))),
                                  color: Colors.grey[200]),
                            );
                          }),
                ),
              ),
            ));
  }
}
