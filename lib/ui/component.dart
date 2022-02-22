import 'package:flutter/material.dart';
import 'package:dapp/ui/qr_scanner.dart';

class Component extends StatefulWidget {
  const Component({Key? key}) : super(key: key);

  @override
  _ComponentState createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        labelText: 'Enter product address',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      style: TextStyle(color: Colors.white)),
                ),
                Text('OR'),
                FloatingActionButton.extended(
                    heroTag: "scan_button",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QRViewScanner(),
                      ));
                    },
                    backgroundColor: Colors.blue[400],
                    icon: Icon(Icons.qr_code),
                    label: Text('Scan QR code')),
              ]))),
    );
  }
}
