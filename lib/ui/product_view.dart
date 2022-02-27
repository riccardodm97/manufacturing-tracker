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
            ),
            body: SafeArea(
                child: Container(
                    color: Colors.grey[800],
                    child: FutureBuilder(
                        future: model.getProductDetails(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text("There is no connection");

                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());

                            case ConnectionState.done:
                              if (snapshot.data != null) {
                                dynamic myMap = snapshot.data;
                                return Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24.0, 12.0, 24.0, 12.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4.0) //
                                                        )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Product name: ${myMap['product_name']}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24.0, 12.0, 24.0, 12.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4.0) //
                                                        )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Manufacturer address: ${myMap['manufacturer_address']}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24.0, 12.0, 24.0, 12.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4.0) //
                                                        )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Manufacturer name: ${myMap['manufacturer_name']}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24.0, 12.0, 24.0, 12.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4.0) //
                                                        )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Production location: ${myMap['production_location']}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24.0, 12.0, 24.0, 12.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4.0) //
                                                        )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Production date: ${myMap['production_date']}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: FloatingActionButton.extended(
                                            heroTag: "see_constituents_button",
                                            onPressed: () {
                                              //##############################
                                            },
                                            backgroundColor: Colors.blue[400],
                                            icon: const Icon(
                                                Icons.manage_search_rounded),
                                            label:
                                                const Text('See constituents')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: model.busy
                                            ? const CircularProgressIndicator()
                                            : FloatingActionButton.extended(
                                                heroTag: "buy_button",
                                                onPressed: () {
                                                  //################################
                                                },
                                                backgroundColor:
                                                    Colors.red[400],
                                                icon: const Icon(Icons
                                                    .add_shopping_cart_rounded),
                                                label: const Text('Buy')),
                                      ),
                                    ]));
                              }
                              // here your snapshot data is null so SharedPreferences has no data...
                              return const Text("Data could not be loaded");
                          }
                        })))));
  }
}
