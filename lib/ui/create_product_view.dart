import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/create_product_view_model.dart';

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
              title: const Text('Create Product'),
              backgroundColor: Colors.grey[900],
            ),
            body: Container(
                color: Colors.grey[800],
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
                        child: TextField(
                            controller: productNameController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              labelText: 'Product name',
                              labelStyle: TextStyle(color: Colors.grey[400]),
                            ),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                        child: TextField(
                            controller: manufacturerNameController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              labelText: 'Manufacturer Name',
                              labelStyle: TextStyle(color: Colors.grey[400]),
                            ),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                        child: TextField(
                            controller: productionLocationController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              labelText: 'Production Location',
                              labelStyle: TextStyle(color: Colors.grey[400]),
                            ),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FloatingActionButton.extended(
                            heroTag: "add_component_button",
                            onPressed: () {
                              model.navigateToSelectComponentsView(context);
                            },
                            backgroundColor: Colors.blue[400],
                            icon: const Icon(Icons.add),
                            label: const Text('Add component')),
                      ),
                      Flexible(child: listComponents(model.selectedComponents)),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FloatingActionButton.extended(
                            heroTag: "save_button",
                            onPressed: () {
                              model.saveNewProduct(
                                  productNameController.text,
                                  manufacturerNameController.text,
                                  productionLocationController.text);
                            },
                            backgroundColor: Colors.red[400],
                            icon: const Icon(Icons.save),
                            label: const Text('Save')),
                      ),
                    ])))));
  }

  Widget listComponents(components) {
    return ListView.builder(
      itemCount: components?.length ?? 0,
      itemBuilder: (context, index) {
        return Row(children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0) //
                        )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${index + 1}° Component: ${components[index].name}',
                      style: const TextStyle(color: Colors.white)),
                )),
          )),
        ]);
      },
    );
  }
}

// _addTile(),

// Widget _addTile() {
//   return ListTile(
//     title: Padding(
//       padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
//       child: FloatingActionButton.extended(
//           heroTag: "add_component_button",
//           onPressed: () {
//             final controller = TextEditingController();
//             final field = TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white, width: 1.5)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white, width: 1.5)),
//                 labelText:
//                     "Enter component ${_controllers.length + 1} address",
//                 labelStyle: TextStyle(color: Colors.grey[400]),
//               ),
//               style: TextStyle(color: Colors.white),
//             );

//             setState(() {
//               _controllers.add(controller);
//               _fields.add(field);
//             });
//           },
//           backgroundColor: Colors.blue[400],
//           icon: Icon(Icons.add),
//           label: Text('Add component')),
//     ),
//   );
// }
