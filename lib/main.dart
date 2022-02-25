import 'package:dapp/service/auth_service.dart';
import 'package:dapp/ui/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/home_view.dart';

import 'setup/locator.dart';
import 'setup/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  await serviceLocator.allReady();

  await serviceLocator<AuthService>().tryLoadUserData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeView(),
        '/logIn': (context) => LoginView(),
        // '/createProduct': (context) => Upload(),
        // '/download': (context) => Download(),
        // '/saved': (context) => Saved(),
        // '/component': (context) => Component(),
        // '/view_product': (context) => ViewProduct(),
      },
    );
  }
}


// TODO togliere le route / pagine di UI da qui 