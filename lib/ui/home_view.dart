import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Food Traceability'),
              backgroundColor: Colors.grey[900],
            ),
            body: Container(
              color: Colors.grey[800],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          model.navigateToLoginView(context);
                        },
                        child: const Text('LogIn'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[400],
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          model.navigateToCreateProductView(context);
                        },
                        child: const Text('Create New Product'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[400],
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          model.navigateFindProductView(context);
                        },
                        child: const Text('Find Product'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[400],
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          model.navigateMyProductsView(context);
                        },
                        child: const Text('My Products'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[400],
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ),
            )));
  }
}
