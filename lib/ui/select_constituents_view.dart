import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/select_constituents_view_model.dart';

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
          title: const Text('Food Traceability'),
          backgroundColor: Colors.grey[900],
          leading: BackButton(
            onPressed: () => model.navigateBack(context),
          ),
        ),
        body: Container(
          color: Colors.grey[800],
          child: Center(
            child: model.busy
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: model.possibleConstituents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Card(
                          child: ListTile(
                              onTap: () {
                                if (model.selectedConstituents.contains(
                                    model.possibleConstituents[index])) {
                                  model.removeFromConstituentsList(
                                      model.possibleConstituents[index]);
                                }
                              },
                              onLongPress: () {
                                model.addToConstituentsList(
                                    model.possibleConstituents[index]);
                              },
                              title: Text(model.possibleConstituents[index],
                                  style: const TextStyle(fontSize: 24.0)),
                              leading: const CircleAvatar(
                                  child: Icon(Icons.bookmark_border_outlined))),
                          color: model.selectedConstituents
                                  .contains(model.possibleConstituents[index])
                              ? Colors.blue[200]
                              : Colors.grey[200],
                        ),
                      );
                    }),
          ),
        ),
        floatingActionButton: model.selectedConstituents.isEmpty
            ? null
            : FloatingActionButton(
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
