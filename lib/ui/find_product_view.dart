import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dapp/ui/colors.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color1,
        ),
        body: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              bottom: defaultPadding,
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: color1,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: const [
                    Image(
                        image: AssetImage('assets/images/qrcodescan.png'),
                        width: 80.0,
                        height: 80.0,
                        color: color7),
                    SizedBox(height: 10.0),
                    Text(
                        'Enter product address or scan QR code\nto obtain product information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color7,
                          fontSize: 16.0,
                        ))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      color: color7,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: TextField(
                                controller: productAddressController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                          color: color1, width: 1.5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                          color: color1, width: 1.5)),
                                  labelText: 'Product address',
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(127, 49, 99, 0)),
                                ),
                                style: const TextStyle(color: color1)),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: color1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 1.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  // barcode variable contains the QR scanned ('null' if nothing was scanned)
                                  barcode = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QRViewScanner(),
                                    ),
                                  );
                                  setState(() {
                                    productAddressController.text =
                                        barcode ?? 'No QR score scanned';
                                  });
                                },
                                icon: const Icon(Icons.qr_code),
                                label: const Text(
                                  'Scan QR code',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: color1,
                                  onPrimary: color7,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                )),
                          ),
                        ])),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/product',
                            arguments: [productAddressController.text, true]);
                      },
                      icon: const Icon(Icons.cloud_download_rounded),
                      label: const Text(
                        'View',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        primary: color7,
                        onPrimary: color1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      )),
                ),
              ],
            ),
          ),
        ]));
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
