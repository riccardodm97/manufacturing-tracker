import 'package:web3dart/web3dart.dart';

import 'package:dapp/service/web3_service.dart';
import 'package:dapp/locator.dart';

class ProductService {
  static const String factoryContract = "ProductFactory";
  static const String productContract = "Product";

  final Web3Service _web3service = serviceLocator<Web3Service>();

  DeployedContract? factoryP;
  DeployedContract? currentP;

  Future<void> loadFactoryProduct(String factoryAddress) async {
    factoryP = await _web3service.loadContract(factoryAddress, factoryContract);
  }

  Future<void> loadCurrentProduct(String productAddress) async {
    currentP = await _web3service.loadContract(productAddress, productContract);
  }

  Future<String> addConstituent(String constituentAddress) async {
    return await _web3service.submitTransaction(currentP!, "addConstituent",
        [EthereumAddress.fromHex(constituentAddress)]);
  }

  Future<String> createProduct(String name, String manufacturerName,
      String productionLocation, BigInt productionDate) async {
    return await _web3service.submitTransaction(factoryP!, "createProduct",
        [name, manufacturerName, productionLocation, productionDate]);
  }

  Future<String> markAsFinished() async {
    return await _web3service
        .submitTransaction(currentP!, "markAsFinished", []);
  }

  Future<String> markAsUsed() async {
    return await _web3service.submitTransaction(currentP!, "markAsUsed", []);
  }

  Future<String> transfer(String newOwnerAddress) async {
    return await _web3service.submitTransaction(
        currentP!, "transfer", [EthereumAddress.fromHex(newOwnerAddress)]);
  }

  Future<List<String>> getConstituents() async {
    List<dynamic> response =
        await _web3service.queryContract(currentP!, "getConstituents", []);

    return [response[0], response[1]]; //TODO gestire la riposta
  }

  Future<String> getName() {
    // TODO: implement getName
    throw UnimplementedError();
  }

  Future<Map<String, String>> getProductDetails() {
    // TODO: implement getProductDetails
    throw UnimplementedError();
  }
}
