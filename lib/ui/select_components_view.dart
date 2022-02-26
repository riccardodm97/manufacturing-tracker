import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/select_components_view_model.dart';

class SelectComponentsView extends StatefulWidget {
  const SelectComponentsView({Key? key}) : super(key: key);

  @override
  _SelectComponentsViewState createState() => _SelectComponentsViewState();
}

class _SelectComponentsViewState extends State<SelectComponentsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectComponentsViewModel>.reactive(
      viewModelBuilder: () => SelectComponentsViewModel(),
      onModelReady: (model) => model.onStartup(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Food Traceability'),
          backgroundColor: Colors.grey[900],
        ),
        body: Container(
          color: Colors.grey[800],
          child: Center(
            child: model.busy
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: model.possibleComponents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Card(
                          child: Container(
                            color: model.selectedComponents
                                    .contains(model.possibleComponents[index])
                                ? Colors.blue.withOpacity(0.5)
                                : Colors.transparent,
                            child: ListTile(
                                onTap: () {
                                  if (model.selectedComponents.contains(
                                      model.possibleComponents[index])) {
                                    model.removeFromComponentsList(
                                        model.possibleComponents[index]);
                                  }
                                },
                                onLongPress: () {
                                  model.addToComponentsList(
                                      model.possibleComponents[index]);
                                },
                                title: Text(model.possibleComponents[index],
                                    style: const TextStyle(fontSize: 24.0)),
                                leading: const CircleAvatar(
                                    child:
                                        Icon(Icons.bookmark_border_outlined))),
                          ),
                          color: Colors.grey[200],
                        ),
                      );
                    }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.navigateBack(context);
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.save_alt),
        ),
      ),
    );
  }
}
