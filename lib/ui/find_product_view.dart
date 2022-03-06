import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'colors.dart';

class FindProductView extends StatefulWidget {
  const FindProductView({Key? key}) : super(key: key);

  @override
  State<FindProductView> createState() => _FindProductViewState();
}

class _FindProductViewState extends State<FindProductView> {
  final productAddressController = TextEditingController();
  late final String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Find product',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
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
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    const Image(
                        image: AssetImage('assets/images/find-product-64.png'),
                        width: 80.0,
                        height: 80.0,
                        color: color7),
                    const SizedBox(height: 10.0),
                    Text(
                        'Enter product address or scan QR code\nto obtain product information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color7,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: color7,
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: color1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.28,
                                height: 1.5,
                              ),
                              Text('OR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: color1,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  )),
                              Container(
                                decoration: const BoxDecoration(
                                  color: color1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.28,
                                height: 1.5,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  // barcode variable contains the QR scanned ('null' if nothing was scanned)
                                  code = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) =>
                                        const BarcodeScannerWithoutController(),
                                  ));
                                  setState(() {
                                    productAddressController.text =
                                        code ?? 'No QR score scanned';
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
                        productAddressController.clear();
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

class BarcodeScannerWithoutController extends StatefulWidget {
  const BarcodeScannerWithoutController({Key? key}) : super(key: key);

  @override
  _BarcodeScannerWithoutControllerState createState() =>
      _BarcodeScannerWithoutControllerState();
}

class _BarcodeScannerWithoutControllerState
    extends State<BarcodeScannerWithoutController>
    with SingleTickerProviderStateMixin {
  String? barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(builder: (context) {
        return Stack(
          children: [
            MobileScanner(
                fit: BoxFit.contain,
                onDetect: (barcode, args) {
                  if (this.barcode != barcode.rawValue) {
                    setState(() {
                      this.barcode = barcode.rawValue;
                      Navigator.pop(context, this.barcode);
                    });
                  }
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: FittedBox(
                          child: Text(
                            'Scan QR code!',
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: color6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
