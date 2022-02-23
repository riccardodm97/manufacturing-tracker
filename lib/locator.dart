import 'package:get_it/get_it.dart';

import 'package:dapp/service/persistence_service.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/product_service.dart';
import 'package:dapp/service/web3_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerSingletonAsync<PersistenceService>(
      () async => PersistenceService.init());

  serviceLocator.registerSingletonWithDependencies<AuthService>(
      () => AuthService(),
      dependsOn: [PersistenceService]);

  serviceLocator.registerSingletonWithDependencies<Web3Service>(
      () => Web3Service(),
      dependsOn: [AuthService]);

  serviceLocator.registerSingletonWithDependencies<ProductService>(
      () => ProductService(),
      dependsOn: [Web3Service]);
}
