abstract class IProductService {
  Future<String> createProduct(String name, String manufacturerName,
      String productionLocation, BigInt productionDate);

  Future<String> addConstituent(String constituentAddress);

  Future<String> transfer(String newOwnerAddress);

  Future<String> markAsUsed();

  Future<String> markAsFinished();

  Future<Map<String, String>> getProductDetails();

  Future<String> getName();

  Future<List<String>> getConstituents();
}
