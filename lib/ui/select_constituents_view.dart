import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/select_constituents_view_model.dart';
import 'colors.dart';

class SelectConstituentsView extends StatefulWidget {
  const SelectConstituentsView({Key? key}) : super(key: key);

  @override
  _SelectConstituentsViewState createState() => _SelectConstituentsViewState();
}

class _SelectConstituentsViewState extends State<SelectConstituentsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectConstituentsViewModel>.reactive(
      viewModelBuilder: () => SelectConstituentsViewModel(),
      onModelReady: (model) => model.onStartup(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Select constituents',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => model.navigateBack(context),
          ),
          centerTitle: true,
          elevation: 10,
          backgroundColor: color1,
        ),
        body: Center(
          child: model.busy
              ? const CircularProgressIndicator()
              : model.possibleConstituents.isNotEmpty
                  ? ListView.builder(
                      itemCount: model.possibleConstituents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: ListTile(
                              onTap: () {
                                model.addToConstituentsMap(
                                    model.possibleConstituentsAddress[index]);
                              },
                              onLongPress: () {
                                if (model.selectedConstituentsAddress.contains(
                                    model.possibleConstituentsAddress[index])) {
                                  model.removeFromConstituentsMap(
                                      model.possibleConstituentsAddress[index]);
                                }
                              },
                              title: Text(
                                  model.possibleConstituentsNames[index],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06)),
                            ),
                            color: model.selectedConstituentsAddress.contains(
                                    model.possibleConstituentsAddress[index])
                                ? color4
                                : color7,
                          ),
                        );
                      })
                  : const Center(
                      child: Text('No products to show',
                          style: TextStyle(fontSize: 24.0, color: color1)),
                    ),
        ),
        floatingActionButton: model.selectedConstituents.isEmpty
            ? null
            : FloatingActionButton(
                elevation: 10,
                onPressed: () {
                  model.navigateBack(context);
                },
                backgroundColor: color1,
                child: const Icon(Icons.save_alt),
              ),
      ),
    );
  }
}
