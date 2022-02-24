import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key}) : super(key: key);

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  dynamic productAddress;

  @override
  Widget build(BuildContext context) {
    productAddress = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Product'),
          backgroundColor: Colors.grey[900],
        ),
        body: Center(child: Text(productAddress)));
  }
}
