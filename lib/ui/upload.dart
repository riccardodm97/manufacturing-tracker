import 'package:flutter/material.dart';
import 'package:dapp/ui/qr_scanner.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Food Traceability'),
          backgroundColor: Colors.grey[900],
        ),
        body: Container(
            color: Colors.grey[800],
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
                    child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Enter product name',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                    child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Enter product date',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                    child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Enter product ID',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  _addTile(),
                  Flexible(child: _listView()),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FloatingActionButton.extended(
                        heroTag: "save_button",
                        onPressed: () {},
                        backgroundColor: Colors.red[400],
                        icon: Icon(Icons.save),
                        label: Text('Save')),
                  ),
                ]))));
  }

  Widget _addTile() {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
        child: FloatingActionButton.extended(
            heroTag: "add_component_button",
            onPressed: () {
              final controller = TextEditingController();
              final field = TextField(
                controller: controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5)),
                  labelText:
                      "Enter component ${_controllers.length + 1} address",
                  labelStyle: TextStyle(color: Colors.grey[400]),
                ),
                style: TextStyle(color: Colors.white),
              );

              setState(() {
                _controllers.add(controller);
                _fields.add(field);
              });
            },
            backgroundColor: Colors.blue[400],
            icon: Icon(Icons.add),
            label: Text('Add component')),
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Row(children: <Widget>[
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(24.0, 12.0, 8.0, 12.0),
            child: _fields[index],
          )),
          Container(
            margin: EdgeInsets.fromLTRB(8.0, 12.0, 24.0, 12.0),
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewScanner(),
                ));
              },
              backgroundColor: Colors.blue[400],
              icon: Icon(Icons.qr_code),
              label: Text('QR'),
            ),
          ),
        ]);
      },
    );
  }
}
