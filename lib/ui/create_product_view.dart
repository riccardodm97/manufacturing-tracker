import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/create_product_view_model.dart';
import 'package:dapp/ui/colors.dart';

class CreateProductView extends StatefulWidget {
  const CreateProductView({Key? key}) : super(key: key);

  @override
  _CreateProductViewState createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final productNameController = TextEditingController();
  final manufacturerNameController = TextEditingController();
  final productionLocationController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    productNameController.dispose();
    manufacturerNameController.dispose();
    productionLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateProductViewModel>.reactive(
        viewModelBuilder: () => CreateProductViewModel(),
        builder: (context, model, child) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                'Add product',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: color1,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => model.navigateBack(context),
              ),
            ),
            body: Column(children: [
              Container(
                padding: const EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
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
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 4.0),
                      child: TextField(
                          controller: productNameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide: const BorderSide(
                                    color: color7, width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide: const BorderSide(
                                    color: color7, width: 1.5)),
                            labelText: 'Product name',
                            labelStyle:
                                TextStyle(color: color7.withOpacity(0.5)),
                          ),
                          style: const TextStyle(color: color7)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 4.0),
                      child: TextField(
                          controller: manufacturerNameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide: const BorderSide(
                                    color: color7, width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide: const BorderSide(
                                    color: color7, width: 1.5)),
                            labelText: 'Manufacturer name',
                            labelStyle:
                                TextStyle(color: color7.withOpacity(0.5)),
                          ),
                          style: const TextStyle(color: color7)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                      child: TextField(
                          controller: productionLocationController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide: const BorderSide(
                                    color: color7, width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide: const BorderSide(
                                    color: color7, width: 1.5)),
                            labelText: 'Production location',
                            labelStyle:
                                TextStyle(color: color7.withOpacity(0.5)),
                          ),
                          style: const TextStyle(color: color7)),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: color7,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  32.0, 8.0, 32.0, 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Constituents',
                                      style: TextStyle(
                                          fontSize: 16.0, color: color1)),
                                  Text(
                                      '${model.selectedConstituents.length} items',
                                      style: const TextStyle(
                                          fontSize: 12.0, color: color1))
                                ],
                              ),
                            ),
                            model.selectedConstituents.isEmpty
                                ? Expanded(
                                    child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 8.0),
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: ListTile(
                                              onTap: () {
                                                model
                                                    .navigateToSelectConstituentsView(
                                                        context);
                                              },
                                              title: const Center(
                                                child: Icon(Icons.add_rounded,
                                                    color: color7, size: 36.0),
                                              ),
                                            ),
                                            color: color1,
                                          )),
                                    ),
                                  ))
                                : Expanded(
                                    child: ScrollConfiguration(
                                    behavior: NoGlowBehaviour(),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            model.selectedConstituents.length +
                                                1,
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              model.selectedConstituents
                                                  .length) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 8.0),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                    ),
                                                    child: ListTile(
                                                      onTap: () {
                                                        model
                                                            .navigateToSelectConstituentsView(
                                                                context);
                                                      },
                                                      title: const Center(
                                                        child: Icon(
                                                            Icons.add_rounded,
                                                            color: color7,
                                                            size: 36.0),
                                                      ),
                                                    ),
                                                    color: color1,
                                                  )),
                                            );
                                          } else {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 8.0),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                    ),
                                                    child: ListTile(
                                                      onTap: () {},
                                                      title: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                              model.selectedConstituents[
                                                                  index],
                                                              maxLines: 3,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color:
                                                                      color7)),
                                                        ],
                                                      ),
                                                    ),
                                                    color: color1,
                                                  )),
                                            );
                                          }
                                        }),
                                  )),
                          ],
                        )),
                    model.busy
                        ? const CircularProgressIndicator()
                        : ElevatedButton.icon(
                            onPressed: () {
                              model.saveNewProduct(
                                productNameController.text,
                                manufacturerNameController.text,
                                productionLocationController.text,
                                context,
                              );
                            },
                            icon: const Icon(Icons.save),
                            label: const Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: color7,
                              onPrimary: color1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            )),
                  ]))
            ])));
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
