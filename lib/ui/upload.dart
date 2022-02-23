import 'package:flutter/material.dart';
import 'package:dapp/ui/qr_scanner.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  // List<TextEditingController> _controllers = [];
  // dynamic _fields = [];
  dynamic components = [];

  // @override
  // void dispose() {
  //   for (final controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

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
                          labelText: 'Product name',
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
                          labelText: 'Product date',
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
                          labelText: 'Product ID',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FloatingActionButton.extended(
                        heroTag: "add_component_button",
                        onPressed: () async {
                          components =
                              await Navigator.pushNamed(context, '/component');
                          setState(() {
                            listComponents(components);
                          });
                        },
                        backgroundColor: Colors.blue[400],
                        icon: Icon(Icons.add),
                        label: Text('Add component')),
                  ),
                  Flexible(child: listComponents(components)),
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

  Widget listComponents(components) {
    return ListView.builder(
      itemCount: components.length,
      itemBuilder: (context, index) {
        return Row(children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(4.0) //
                        )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${index + 1}° Component: ${components[index]}',
                      style: TextStyle(color: Colors.white)),
                )),
          )),
        ]);
      },
    );
  }
}

// _addTile(),

// Widget _addTile() {
//   return ListTile(
//     title: Padding(
//       padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
//       child: FloatingActionButton.extended(
//           heroTag: "add_component_button",
//           onPressed: () {
//             final controller = TextEditingController();
//             final field = TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white, width: 1.5)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white, width: 1.5)),
//                 labelText:
//                     "Enter component ${_controllers.length + 1} address",
//                 labelStyle: TextStyle(color: Colors.grey[400]),
//               ),
//               style: TextStyle(color: Colors.white),
//             );

//             setState(() {
//               _controllers.add(controller);
//               _fields.add(field);
//             });
//           },
//           backgroundColor: Colors.blue[400],
//           icon: Icon(Icons.add),
//           label: Text('Add component')),
//     ),
//   );
// }

// Container(
//   margin: EdgeInsets.fromLTRB(8.0, 12.0, 24.0, 12.0),
//   child: FloatingActionButton.extended(
//     heroTag: null,
//     onPressed: () {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const QRViewScanner(),
//       ));
//     },
//     backgroundColor: Colors.blue[400],
//     icon: Icon(Icons.qr_code),
//     label: Text('QR'),
//   ),
// ),
