import 'package:flutter/material.dart';
import 'package:dapp/ui_temp/qr_scanner.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  final productAddressController = TextEditingController();
  dynamic barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Download'),
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
                        controller: productAddressController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Product address',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('OR', style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () async {
                        // barcode variable contains the QR scanned ('null' if nothing was scanned)
                        barcode = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const QRViewScanner(),
                          ),
                        );
                        setState(() {
                          productAddressController.text =
                              barcode ?? 'No QR score scanned';
                        });
                      },
                      backgroundColor: Colors.blue[400],
                      icon: Icon(Icons.qr_code),
                      label: Text('Scan QR code'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FloatingActionButton.extended(
                        heroTag: "save_button",
                        onPressed: () {
                          Navigator.pushNamed(context, '/view_product',
                              arguments: productAddressController.text);
                        },
                        backgroundColor: Colors.red[400],
                        icon: Icon(Icons.cloud_download_rounded),
                        label: Text('View')),
                  ),
                ]))));
  }
}
