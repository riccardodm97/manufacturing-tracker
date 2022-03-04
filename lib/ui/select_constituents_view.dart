import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/select_constituents_view_model.dart';
import 'package:dapp/ui/colors.dart';

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
            'Select ingredients',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 10,
          backgroundColor: color1,
        ),
        body: Center(
          child: model.busy
              ? const CircularProgressIndicator()
              : ListView.builder(
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
                              model.addToConstituentsList(
                                  model.possibleConstituents[index]);
                            },
                            onLongPress: () {
                              if (model.selectedConstituents.contains(
                                  model.possibleConstituents[index])) {
                                model.removeFromConstituentsList(
                                    model.possibleConstituents[index]);
                              }
                            },
                            title: Text(model.possibleConstituents[index],
                                style: const TextStyle(fontSize: 24.0)),
                            leading: const CircleAvatar(
                                backgroundColor: color1,
                                child: Icon(Icons.bookmark_border_outlined))),
                        color: model.selectedConstituents
                                .contains(model.possibleConstituents[index])
                            ? color4
                            : color7,
                      ),
                    );
                  }),
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
