import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/product_view_model.dart';
import 'package:dapp/ui/colors.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List;
    return ViewModelBuilder<ProductViewModel>.nonReactive(
        viewModelBuilder: () => ProductViewModel(arguments[0], arguments[1]),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: color1,
            ),
            body: FutureBuilder(
                future: model.getProductDetails(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text("There is no connection");

                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());

                    case ConnectionState.done:
                      if (snapshot.data != null) {
                        dynamic myMap = snapshot.data;
                        return Column(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                              left: defaultPadding,
                              right: defaultPadding,
                              bottom: defaultPadding,
                            ),
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: const BoxDecoration(
                              color: color1,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text('${myMap['product_name']}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: color7,
                                            fontSize: 36.0,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.account_circle_rounded,
                                                color: color7,
                                                size: 48.0,
                                              ),
                                              SizedBox(width: 20.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${myMap['manufacturer_name']}',
                                                      style: const TextStyle(
                                                          color: color7,
                                                          fontSize: 24.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      '${myMap['manufacturer_address']}',
                                                      style: const TextStyle(
                                                        color: color7,
                                                        fontSize: 12.0,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.room_rounded,
                                                color: color7,
                                                size: 48.0,
                                              ),
                                              SizedBox(width: 20.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${myMap['production_location']}',
                                                      style: const TextStyle(
                                                          color: color7,
                                                          fontSize: 24.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today_rounded,
                                                color: color7,
                                                size: 48.0,
                                              ),
                                              SizedBox(width: 20.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${myMap['production_date']}',
                                                      style: const TextStyle(
                                                          color: color7,
                                                          fontSize: 24.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: const BoxDecoration(
                                      color: color7,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(36)),
                                    ),
                                    child: FutureBuilder(
                                        future: model.getProductConstituents(),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                              return const Text(
                                                  "There is no connection");

                                            case ConnectionState.active:
                                            case ConnectionState.waiting:
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());

                                            case ConnectionState.done:
                                              if (snapshot.data != null) {
                                                dynamic constituents =
                                                    snapshot.data;
                                                if (constituents.length != 0) {
                                                  return ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          constituents.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      32.0,
                                                                  horizontal:
                                                                      8.0),
                                                          child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              child: Card(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              36.0),
                                                                ),
                                                                child: ListTile(
                                                                  onTap: () {
                                                                    model.navigateToProductView(
                                                                        context,
                                                                        constituents[
                                                                            index]);
                                                                  },
                                                                  title: Text(
                                                                      constituents[
                                                                          index],
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          color:
                                                                              color7)),
                                                                ),
                                                                color: color1,
                                                              )),
                                                        );
                                                      });
                                                }
                                                return const Center(
                                                  child: Text(
                                                      "This product has no constituents"),
                                                );
                                              }
                                              // here your snapshot data is null so SharedPreferences has no data...
                                              return const Center(
                                                child: Text(
                                                    "This product has no constituents"),
                                              );
                                          }
                                        })),
                                Visibility(
                                  visible: arguments[1] && model.isUserLogged,
                                  maintainSize: false,
                                  child: ElevatedButton.icon(
                                      onPressed: () {
                                        model.buyProduct();
                                      },
                                      icon: const Icon(
                                          Icons.add_shopping_cart_rounded),
                                      label: const Text('Buy'),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: color7,
                                        onPrimary: color1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(36.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 15),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ])),
                        ]);
                      }
                      // here your snapshot data is null so SharedPreferences has no data...
                      return const Text("There are no saved products");
                  }
                })));
  }
}
