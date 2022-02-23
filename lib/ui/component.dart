import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Component extends StatefulWidget {
  const Component({Key? key}) : super(key: key);

  @override
  _ComponentState createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Food Traceability'),
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
                          title: Text(viewModel.products[index],
                              style: TextStyle(fontSize: 24.0)),
                          leading: CircleAvatar(
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

// ViewModel
class HomeViewModel extends ChangeNotifier {
  List<String> products = [
    'Farina',
    'Acqua',
    'Sale',
    'Pomodoro',
    'Uova',
    'Latte',
    'Tonno',
    'Banana',
    'Salame',
    'Ananas',
    'Mela'
  ];
  List<String> components = [];

  void getComponents(index) {
    components.add(products[index]);
    notifyListeners();
  }
}
