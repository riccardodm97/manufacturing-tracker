import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service/auth_service.dart';
import '../service/product_service.dart';
import '../setup/locator.dart';
import 'home_view.dart';
import 'create_product_view.dart';
import 'my_products_view.dart';
import 'select_constituents_view.dart';
import 'find_product_view.dart';
import 'colors.dart';
import 'product_view.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Product Checker App',
      theme: ThemeData(
        scaffoldBackgroundColor: color6,
        primaryColor: color7,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      routes: {
        '/': (context) => const HomeView(),
        '/createProduct': (context) => const CreateProductView(),
        '/selectConstituents': (context) => const SelectConstituentsView(),
        '/findProduct': (context) => const FindProductView(),
        '/product': (context) => const ProductView(),
        '/myProducts': (context) => const MyProductsView(),
      },
    );
  }
}
