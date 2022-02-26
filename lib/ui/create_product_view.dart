import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/create_product_view_model.dart';

class CreateProductView extends StatelessWidget {
  CreateProductView({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateProductViewModel>.reactive(
        viewModelBuilder: () => CreateProductViewModel(),
        builder: (context, viewModel, child) => Scaffold(
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
                            controller: nameController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.5)),
                              labelText: 'Product Name',
                              labelStyle: TextStyle(color: Colors.grey[400]),
                            ),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                        child: TextField(
                            controller: dateController,
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
                            controller: idController,
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
                            onPressed: () async {
                              components = await Navigator.pushNamed(
                                  context, '/component');
                              setState(() {
                                listComponents(components);
                              });
                            },
                            backgroundColor: Colors.blue[400],
                            icon: Icon(Icons.add),
                            label: Text('Add component')),
                      ),
                      Flexible(child: listComponents(components)),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FloatingActionButton.extended(
                            heroTag: "save_button",
                            onPressed: () {
                              viewModel.addProduct(Product(
                                  name: nameController.text,
                                  date: dateController.text,
                                  id: idController.text,
                                  components:
                                      viewModel.getComponentsName(components)));
                              // print(viewModel.getProducts());
                            },
                            backgroundColor: Colors.red[400],
                            icon: Icon(Icons.save),
                            label: Text('Save')),
                      ),
                    ])))));
  }
}
