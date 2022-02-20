import 'package:dapp/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:dapp/service/config.dart';

void main() {
  test('prova', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    const key =
        "2d0977ca3c6ce9332d01a9fbf4445e462aede799c931a3a5ba95238233ae69df";
    const factoryAddress = "0xC369A5F5e1ca3668b04a5edA5a23aEe9B42cdBf6";

    ProductService p = ProductService(key, factoryAddress);

    // print(p.userAddress);

    Credentials credentials = EthPrivateKey.fromHex(key);
    //EthereumAddress userAddress = await credentials.extractAddress();

    // expect(userAddress,
    //     EthereumAddress.fromHex("0x90deDB852718CB00F19593d5486Ad7D16Df7abb2"));

    //print(p.userAddress);
  });
}
