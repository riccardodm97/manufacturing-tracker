import 'package:dapp/service/base_service.dart';
import 'package:dapp/service/config.dart';
import 'package:dapp/service/product_service_interface.dart';
import 'package:web3dart/web3dart.dart';

class ProductService extends BaseService implements IProductService {
  late DeployedContract factory;
  DeployedContract? currentProduct;

  ProductService(String privateKey, String factoryAddress) : super(privateKey) {
    _setFactory(factoryAddress);
  }

  void _setFactory(String factoryAddress) async {
    factory = await loadContract(factoryAddress, Config.factoryContract);
  }

  void loadCurrentProduct(String productAddress) async {
    currentProduct = await loadContract(productAddress, Config.productContract);
  }

  @override
  Future<String> addConstituent(String constituentAddress) async {
    return await submitTransaction(currentProduct!, "addConstituent",
        [EthereumAddress.fromHex(constituentAddress)]);
  }

  @override
  Future<String> createProduct(String name, String manufacturerName,
      String productionLocation, BigInt productionDate) async {
    return await submitTransaction(factory, "createProduct",
        [name, manufacturerName, productionLocation, productionDate]);
  }

  @override
  Future<String> markAsFinished() async {
    return await submitTransaction(currentProduct!, "markAsFinished", []);
  }

  @override
  Future<String> markAsUsed() async {
    return await submitTransaction(currentProduct!, "markAsUsed", []);
  }

  @override
  Future<String> transfer(String newOwnerAddress) async {
    return await submitTransaction(currentProduct!, "transfer",
        [EthereumAddress.fromHex(newOwnerAddress)]);
  }

  @override
  Future<List<String>> getConstituents() async {
    List<dynamic> response =
        await queryContract(currentProduct!, "getConstituents", []);

    return [response[0], response[1]];
  }

  @override
  Future<String> getName() {
    // TODO: implement getName
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> getProductDetails() {
    // TODO: implement getProductDetails
    throw UnimplementedError();
  }
}
