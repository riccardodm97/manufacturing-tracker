// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// import '../viewmodel/create_product_view_model.dart';

// class CreateProductView extends StatelessWidget {
//   CreateProductView({Key? key}) : super(key: key);

//   List<String> components = [];

//   final productNameController = TextEditingController();
//   final manufacturerNameController = TextEditingController();
//   final productionLocationController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<CreateProductViewModel>.reactive(
//         viewModelBuilder: () => CreateProductViewModel(),
//         builder: (context, model, child) => Scaffold(
//             resizeToAvoidBottomInset: false,
//             appBar: AppBar(
//               title: const Text('Create Product'),
//               backgroundColor: Colors.grey[900],
//             ),
//             body: Container(
//                 color: Colors.grey[800],
//                 child: Center(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                       Padding(
//                         padding:
//                             const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
//                         child: TextField(
//                             controller: productNameController,
//                             decoration: InputDecoration(
//                               enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.white, width: 1.5)),
//                               focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.white, width: 1.5)),
//                               labelText: 'Product Name',
//                               labelStyle: TextStyle(color: Colors.grey[400]),
//                             ),
//                             style: const TextStyle(color: Colors.white)),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
//                         child: TextField(
//                             controller: manufacturerNameController,
//                             decoration: InputDecoration(
//                               enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.white, width: 1.5)),
//                               focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.white, width: 1.5)),
//                               labelText: 'Manufacturer Name',
//                               labelStyle: TextStyle(color: Colors.grey[400]),
//                             ),
//                             style: const TextStyle(color: Colors.white)),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
//                         child: TextField(
//                             controller: productionLocationController,
//                             decoration: InputDecoration(
//                               enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.white, width: 1.5)),
//                               focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.white, width: 1.5)),
//                               labelText: 'Production Location',
//                               labelStyle: TextStyle(color: Colors.grey[400]),
//                             ),
//                             style: const TextStyle(color: Colors.white)),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(24.0),
//                         child: FloatingActionButton.extended(
//                             heroTag: "add_component_button",
//                             onPressed: () async {
//                               await model.getPossibleComponents();
//                               components = await showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) =>
//                                     _buildPopupDialog(context, model),
//                               );
//                             },
//                             backgroundColor: Colors.blue[400],
//                             icon: const Icon(Icons.add),
//                             label: const Text('Add component')),
//                       ),
//                       Flexible(child: listComponents(components)),
//                       Padding(
//                         padding: const EdgeInsets.all(24.0),
//                         child: FloatingActionButton.extended(
//                             heroTag: "save_button",
//                             onPressed: () {
//                               model.saveNewProduct(
//                                   productNameController.text,
//                                   manufacturerNameController.text,
//                                   productionLocationController.text);
//                             },
//                             backgroundColor: Colors.red[400],
//                             icon: const Icon(Icons.save),
//                             label: const Text('Save')),
//                       ),
//                     ])))));
//   }
// }

// Widget _buildPopupDialog(BuildContext context, CreateProductViewModel model) {
//   return AlertDialog(
//     title: const Text('My Products'),
//     content: SizedBox(
//       width: 200.0,
//       height: 300.0,
//       child: ListView.builder(
//           itemCount: model.allUserComponents.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
//               child: Card(
//                 child: ListTile(
//                     onTap: () {
//                       model.addToComponentsList(model.allUserComponents[index]);
//                     },
//                     title: Text(model.allUserComponents[index],
//                         style: const TextStyle(fontSize: 24.0)),
//                     leading: const CircleAvatar(
//                         child: Icon(Icons.bookmark_border_outlined))),
//                 color: Colors.grey[200],
//               ),
//             );
//           }),
//     ),
//     actions: <Widget>[
//       FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context, model.selectedComponents);
//         },
//         backgroundColor: Colors.red,
//         child: const Icon(Icons.save_alt),
//       ),
//     ],
//   );
// }

// Widget listComponents(components) {
//   return ListView.builder(
//     itemCount: components?.length ?? 0,
//     itemBuilder: (context, index) {
//       return Row(children: <Widget>[
//         Expanded(
//             child: Padding(
//           padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
//           child: Container(
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 1.5),
//                   borderRadius: const BorderRadius.all(Radius.circular(4.0) //
//                       )),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('${index + 1}° Component: ${components[index]}',
//                     style: const TextStyle(color: Colors.white)),
//               )),
//         )),
//       ]);
//     },
//   );
// }
