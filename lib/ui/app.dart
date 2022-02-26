import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../service/product_service.dart';
import '../setup/locator.dart';
import 'home_view.dart';
import 'login_view.dart';
import 'create_product_view.dart';
import 'product_components_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Future<MyApp> init() async {
    await serviceLocator<AuthService>().tryLoadUserData();

    await serviceLocator<ProductService>().setProductFactory();

    return const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeView(),
        '/logIn': (context) => LoginView(),
        '/createProduct': (context) => CreateProductView(),
        // '/download': (context) => Download(),
        // '/saved': (context) => Saved(),
        '/productComponents': (context) => ProductComponentsView(),
        // '/view_product': (context) => ViewProduct(),
      },
    );
  }
}
