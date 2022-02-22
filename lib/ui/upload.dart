import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
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
                    padding: const EdgeInsets.all(24.0),
                    child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Date',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'ID',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  FloatingActionButton.extended(
                      heroTag: "component_button",
                      onPressed: () {
                        Navigator.pushNamed(context, '/component');
                      },
                      backgroundColor: Colors.blue[400],
                      icon: Icon(Icons.add),
                      label: Text('Component')),
                  FloatingActionButton.extended(
                      heroTag: "save_button",
                      onPressed: () {},
                      backgroundColor: Colors.red[400],
                      icon: Icon(Icons.save),
                      label: Text('Save')),
                ]))));
  }
}
