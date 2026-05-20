import '../entities/product_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class ProductRepository {
  Future<({List<ProductEntity> products, Failure? failure})> getProducts();
}
