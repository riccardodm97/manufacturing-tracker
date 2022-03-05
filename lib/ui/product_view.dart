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
                      return const Text(
                        "There is no connection",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );

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
                            decoration: BoxDecoration(
                              color: color1,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
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
                                            fontSize: 42.0,
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
                                              const CircleAvatar(
                                                radius: 24.0,
                                                backgroundColor: color7,
                                                child: Icon(
                                                  Icons.account_circle_rounded,
                                                  color: color1,
                                                  size: 32.0,
                                                ),
                                              ),
                                              const SizedBox(width: 20.0),
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
                                                        fontSize: 11.0,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 24.0,
                                                backgroundColor: color7,
                                                child: Icon(
                                                  Icons.room_rounded,
                                                  color: color1,
                                                  size: 32.0,
                                                ),
                                              ),
                                              const SizedBox(width: 20.0),
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
                                              const CircleAvatar(
                                                radius: 24.0,
                                                backgroundColor: color7,
                                                child: Icon(
                                                  Icons.calendar_today_rounded,
                                                  color: color1,
                                                  size: 28.0,
                                                ),
                                              ),
                                              const SizedBox(width: 20.0),
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
                                    decoration: BoxDecoration(
                                      color: color7,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(24)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: FutureBuilder(
                                        future: model.getProductConstituents(),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                              return const Text(
                                                "Check your connection",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );

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
                                                  return Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                32.0,
                                                                8.0,
                                                                32.0,
                                                                0.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            const Text(
                                                                'Constituents',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color:
                                                                        color1)),
                                                            Text(
                                                                '${constituents.length} items',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color:
                                                                        color1))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child:
                                                              ScrollConfiguration(
                                                        behavior:
                                                            NoGlowBehaviour(),
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                constituents
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        16.0,
                                                                    horizontal:
                                                                        8.0),
                                                                child: SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.3,
                                                                    child: Card(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(24.0),
                                                                      ),
                                                                      child:
                                                                          ListTile(
                                                                        onTap:
                                                                            () {
                                                                          model.navigateToProductView(
                                                                              context,
                                                                              constituents[index]);
                                                                        },
                                                                        title:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text(constituents[index],
                                                                                maxLines: 3,
                                                                                style: const TextStyle(fontSize: 16.0, color: color7)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      color:
                                                                          color1,
                                                                    )),
                                                              );
                                                            }),
                                                      )),
                                                    ],
                                                  );
                                                }
                                                return const Center(
                                                  child: Text(
                                                    "This product has no constituents",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: color1),
                                                  ),
                                                );
                                              }
                                              // here your snapshot data is null so SharedPreferences has no data...
                                              return const Center(
                                                child: Text(
                                                  "This product has no constituents",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: color1),
                                                ),
                                              );
                                          }
                                        })),
                                Visibility(
                                  visible: model.canShowBuyButton &&
                                      model.isUserLogged,
                                  maintainSize: false,
                                  child: ElevatedButton.icon(
                                      onPressed: () {
                                        model.buyProduct();
                                      },
                                      icon: const Icon(
                                          Icons.add_shopping_cart_rounded),
                                      label: const Text(
                                        'Buy',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        primary: color7,
                                        onPrimary: color1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 15),
                                      )),
                                )
                              ])),
                        ]);
                      }
                      // here your snapshot data is null so SharedPreferences has no data...
                      return const Text(
                        "There are no saved products",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                  }
                })));
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
