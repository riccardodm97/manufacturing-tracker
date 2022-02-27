import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class FindProductView extends StatefulWidget {
  const FindProductView({Key? key}) : super(key: key);

  @override
  State<FindProductView> createState() => _FindProductViewState();
}

class _FindProductViewState extends State<FindProductView> {
  final productAddressController = TextEditingController();
  dynamic barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Find product'),
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
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Product address',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: const TextStyle(color: Colors.white)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
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
                      icon: const Icon(Icons.qr_code),
                      label: const Text('Scan QR code'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FloatingActionButton.extended(
                        heroTag: "save_button",
                        onPressed: () {
                          Navigator.pushNamed(context, '/product',
                              arguments: [productAddressController.text, true]);
                        },
                        backgroundColor: Colors.red[400],
                        icon: const Icon(Icons.cloud_download_rounded),
                        label: const Text('View')),
                  ),
                ]))));
  }
}

class QRViewScanner extends StatefulWidget {
  const QRViewScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewScannerState();
}

class _QRViewScannerState extends State<QRViewScanner> {
  Barcode? barcode;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildQrView(context),
        Positioned(
          top: 20,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: FloatingActionButton.extended(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              backgroundColor: Colors.blue[400],
              icon: const Icon(Icons.flash_on),
              label: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  return Text('Flash: ${snapshot.data}');
                },
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            child: Text(
              (() {
                if (barcode != null) {
                  return 'Barcode Type: ${describeEnum(barcode!.format)}   Data: ${barcode!.code}';
                }
                return 'Scan a code!';
              })(),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 18.0,
              ),
            )),
      ],
    )));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: (MediaQuery.of(context).size.width < 400 ||
                  MediaQuery.of(context).size.height < 400)
              ? 150.0
              : 300.0),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        barcode = scanData;
        Navigator.pop(context, barcode);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
