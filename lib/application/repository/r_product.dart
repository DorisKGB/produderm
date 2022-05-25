import '../../core/entities/product.dart';

abstract class RProduct {
  Future<List<Product>> listProduct();
}
