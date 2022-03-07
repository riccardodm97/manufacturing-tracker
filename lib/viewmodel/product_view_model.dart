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

  final String _productAddress;
  final bool _canShowBuyButton;

  ProductViewModel(this._productAddress, this._canShowBuyButton);

  bool get canShowBuyButton => _canShowBuyButton;

  Future<void> navigateToProductView(
          BuildContext context, String product) async =>
      await Navigator.pushNamed(context, '/product',
          arguments: [product, false]);

  Future<String> buyProduct() async {
    String response = "Something went wrong. Try again!";
    setBusy(true);

    _productService.clearCurrentProduct();
    await _productService.setCurrentProduct(_productAddress);

    try {
      var transactionHash = await _productService.transferOwnership();
      bool status = await _web3Service.getTransactionStatus(transactionHash);

      if (status) {
        Map<String, String> map =
            await _productService.getOldAndNewProductOwner(transactionHash);

        await _productService
            .removeProductFromUser(map["oldOwner"]!, [_productAddress]);
        await _productService.addProductToUser(
            _authService.userAddress.toString(), _productAddress);

        response = "You have bought this product";
      } else {
        response = "Something went wrong. Try again!";
      }
    } catch (e) {
      response = "You can't buy this product";
    }

    _productService.clearCurrentProduct();

    setBusy(false);

    return response;
  }

  Future<Map<String, String>> getProductDetails() async {
    Map<String, String> detailsMap;
    setBusy(true);
    try {
      await _productService.setCurrentProduct(_productAddress);
      detailsMap = await _productService.getProductDetails();
    } catch (e) {
      detailsMap = {};
    }
    setBusy(false);
    return detailsMap;
  }

  Future<Map<String, String>> getProductConstituents() async {
    Map<String, String> productMap = {};

    setBusy(true);

    await _productService.setCurrentProduct(_productAddress);
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
