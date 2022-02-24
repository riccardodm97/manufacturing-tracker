import 'package:flutter/material.dart';
import 'package:dapp/ui/homepage.dart';
import 'package:dapp/ui/upload.dart';
import 'package:dapp/ui/download.dart';
import 'package:dapp/ui/saved.dart';
import 'package:dapp/ui/component.dart';
import 'package:dapp/ui/view_product.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/upload': (context) => Upload(),
        '/download': (context) => Download(),
        '/saved': (context) => Saved(),
        '/component': (context) => Component(),
        '/view_product': (context) => ViewProduct(),
      },
    ));
