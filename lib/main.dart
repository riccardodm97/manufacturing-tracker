import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'setup/locator.dart';
import 'setup/firebase_options.dart';
import 'ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  await serviceLocator.allReady();

  runApp(await MyApp.init());
}
