import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

part 'get_products_usecase.g.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<({List<ProductEntity> products, Failure? failure})> call() {
    return _repository.getProducts();
  }
}

@riverpod
GetProductsUseCase getProductsUseCase(Ref ref) {
  return GetProductsUseCase(ref.watch(productRepositoryProvider));
}
