import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dapp/viewmodels_temp/components_view_model.dart';

class ProductComponentsView extends StatefulWidget {
  const ProductComponentsView({Key? key}) : super(key: key);

  @override
  _ProductComponentsViewState createState() => _ProductComponentsViewState();
}

class _ProductComponentsViewState extends State<ProductComponentsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComponentsViewModel>.reactive(
      viewModelBuilder: () => ComponentsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Food Traceability'),
          backgroundColor: Colors.grey[900],
        ),
        body: Container(
          color: Colors.grey[800],
          child: Center(
            child: ListView.builder(
                itemCount: viewModel.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Card(
                      child: ListTile(
                          onTap: () {
                            viewModel.getComponents(index);
                          },
                          title: Text(viewModel.products[index].name,
                              style: const TextStyle(fontSize: 24.0)),
                          leading: const CircleAvatar(
                              child: Icon(Icons.bookmark_border_outlined))),
                      color: Colors.grey[200],
                    ),
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context, viewModel.components);
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.save_alt),
        ),
      ),
    );
  }
}
