// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dapp/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('prova', () async {
    const key =
        "2d0977ca3c6ce9332d01a9fbf4445e462aede799c931a3a5ba95238233ae69df";
    const factoryAddress = "0xC369A5F5e1ca3668b04a5edA5a23aEe9B42cdBf6";

    ProductService p = ProductService(key, factoryAddress);

    expect(p.userAddress, "0x90deDB852718CB00F19593d5486Ad7D16Df7abb2");
  });
}
