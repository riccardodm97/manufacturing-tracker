import 'package:web3dart/web3dart.dart';

import 'package:dapp/service/web3_service.dart';
import 'package:dapp/locator.dart';

class ProductService {
  static const String factoryContract = "ProductFactory";
  static const String productContract = "Product";

  final Web3Service _web3service = serviceLocator<Web3Service>();

  DeployedContract? _factoryP;
  DeployedContract? _currentP;

  Future<void> setFactoryProduct(String factoryAddress) async {
    _factoryP =
        await _web3service.loadContract(factoryAddress, factoryContract);
  }

  void setCurrentProduct(String productAddress) {
    _currentP = _web3service.loadContract(productAddress, productContract);
  }

  void clearCurrentProduct() {
    _currentP = null;
  }

  Future<String> addConstituent(String constituentAddress) async {
    return await _web3service.submitTransaction(_currentP!, "addConstituent",
        [EthereumAddress.fromHex(constituentAddress)]);
  }

  Future<String> createProduct(String name, String manufacturerName,
      String productionLocation, BigInt productionDate) async {
    return await _web3service.submitTransaction(_factoryP!, 'createProduct',
        [name, manufacturerName, productionLocation, productionDate]);
  }

  Future<String> getNewProductAddress(String transactionHash) async {
    var address = await _web3service.extractEventDataFromReceipt(
        _factoryP!, 'ProductCreated', transactionHash, 0);

    return address[0].toString();
  }

  Future<String> markAsFinished() async {
    return await _web3service
        .submitTransaction(_currentP!, "markAsFinished", []);
  }

  Future<String> markAsUsed() async {
    return await _web3service.submitTransaction(_currentP!, "markAsUsed", []);
  }

  Future<String> transferOwnership() async {
    return await _web3service
        .submitTransaction(_currentP!, "transferOwnership", []);
  }

  Future<List<String>> getConstituents() async {
    List<dynamic> response =
        await _web3service.queryContract(_currentP!, "getConstituents", []);

    var r = response[0];

    var s = r.map((item) => item.toString());

    List<String> items = s.toList();

    return items;
  }

  Future<String> getName() async {
    List<dynamic> response =
        await _web3service.queryContract(_currentP!, "getName", []);

    return response.first.toString();
  }

  Future<Map<String, String>> getProductDetails() async {
    List<dynamic> response =
        await _web3service.queryContract(_currentP!, "getProductDetails", []);

    Map<String, String> map = {};

    map['product_name'] = response[0];
    map['manufacturer_address'] = response[1].toString();
    map['manufacturer_name'] = response[2];
    map['production_location'] = response[3];
    map['production_date'] = response[4].toString();

    return map;
  }
}
