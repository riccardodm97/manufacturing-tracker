import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/homepage.dart';
import 'ui/upload.dart';
import 'ui/download.dart';
import 'ui/saved.dart';
import 'ui/component.dart';

import 'setup/locator.dart';
import 'setup/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/upload': (context) => Upload(),
        '/download': (context) => Download(),
        '/saved': (context) => Saved(),
        '/component': (context) => Component(),
        '/view_product': (context) => ViewProduct(),
      },
    );
  }
}


// TODO togliere le route / pagine di UI da qui 