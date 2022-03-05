import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../service/web3_service.dart';
import '../service/auth_service.dart';
import '../setup/locator.dart';
import 'base_view_model.dart';

class ProductViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
  final Web3Service _web3Service = serviceLocator<Web3Service>();
  final AuthService _authService = serviceLocator<AuthService>();

  final String _product;
  final bool _canShowBuyButton;

  ProductViewModel(this._product, this._canShowBuyButton);

  bool get canShowBuyButton => _canShowBuyButton;

  Future<void> navigateToProductView(
          BuildContext context, String product) async =>
      await Navigator.pushNamed(context, '/product',
          arguments: [product, false]);

  Future<bool> buyProduct() async {
    setBusy(true);

    _productService.clearCurrentProduct();
    await _productService.setCurrentProduct(_product);

    var transactionHash = await _productService.transferOwnership();
    bool status = await _web3Service.getTransactionStatus(transactionHash);

    if (status) {
      Map<String, String> map =
          await _productService.getOldAndNewProductOwner(transactionHash);

      await _productService.removeProductFromUser(map["oldOwner"]!, [_product]);
      await _productService.addProductToUser(
          _authService.userAddress.toString(), _product);
    }
    _productService.clearCurrentProduct();

    setBusy(false);

    return status;
  }

  Future<Map<String, String>> getProductDetails() async {
    setBusy(true);
    await _productService.setCurrentProduct(_product);
    var detailsMap = await _productService.getProductDetails();
    setBusy(false);

    return detailsMap;
  }

  Future<Map<String, String>> getProductConstituents() async {
    Map<String, String> productMap = {};

    setBusy(true);
    await _productService.setCurrentProduct(_product);
    var constituents = await _productService.getConstituents();

    for (String constituent in constituents) {
      await _productService.setCurrentProduct(constituent);
      productMap[constituent] = await _productService.getName();
      _productService.clearCurrentProduct();
    }
    setBusy(false);

    return productMap;
  }
}
