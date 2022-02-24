import 'package:dapp/service/persistence_service.dart';
import 'package:web3dart/web3dart.dart';

import 'web3_service.dart';
import '../setup/locator.dart';

class ProductService {
  static const String factoryContract = "ProductFactory";
  static const String productContract = "Product";

  final Web3Service _web3service = serviceLocator<Web3Service>();
  final PersistenceService _persistenceService =
      serviceLocator<PersistenceService>();

  DeployedContract? _factoryP;
  DeployedContract? _currentP;

  void setFactoryProduct(String factoryAddress) {
    _factoryP = _web3service.loadContract(factoryAddress, factoryContract);
  }

  void setCurrentProduct(String productAddress) {
    _currentP = _web3service.loadContract(productAddress, productContract);
  }

  void clearFactory() => _currentP = null;
  void clearCurrentProduct() => _currentP = null;

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

  Future<Map<String, String>> getOldAndNewProductOwner(
      String transactionHash) async {
    var addressList = await _web3service.extractEventDataFromReceipt(
        _currentP!, 'OwnershipTransferred', transactionHash, 0);

    return {'oldOwner': addressList[0], 'newOwner': addressList[1]};
    // TODO CHECK
  }

  Future<List<String>> getConstituents() async {
    List<dynamic> response =
        await _web3service.queryContract(_currentP!, "getConstituents", []);

    return response.first.map<String>((item) => item.toString()).toList();
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

    // TODO CHECK
  }

  // Future<void> addProductToUser(
  //     String userAddress, String elementAddress) async {
  //   await _persistenceService.addElementToDocumentList(
  //       'users', userAddress, 'products', elementAddress);

  //   //TODO CHECK
  // }

  // Future<void> removeProductFromUser(
  //     String userAddress, String elementAddress) async {
  //   await _persistenceService.deleteElementFromDocumentList(
  //       'users', userAddress, 'products', elementAddress);

  //   //TODO CHECK
  // }
}
