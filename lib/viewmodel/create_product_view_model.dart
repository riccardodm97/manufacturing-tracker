import '../service/product_service.dart';
import '../setup/locator.dart';
import '../viewmodel/base_view_model.dart';

class CreateProductViewModel extends BaseModel {
  final ProductService _productService = serviceLocator<ProductService>();
}
