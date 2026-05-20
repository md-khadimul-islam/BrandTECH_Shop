import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

part 'product_repository_impl.g.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ConnectivityChecker _connectivityChecker;

  const ProductRepositoryImpl(this._remoteDataSource, this._connectivityChecker);

  @override
  Future<({List<ProductEntity> products, Failure? failure})> getProducts() async {
    final hasInternet = await _connectivityChecker.hasInternet();
    if (!hasInternet) {
      return (products: <ProductEntity>[], failure: const NoInternetFailure());
    }

    try {
      final models = await _remoteDataSource.getProducts();
      final entities = models.map((m) => m.toEntity()).toList();
      return (products: entities, failure: null);
    } on NoInternetException {
      return (products: <ProductEntity>[], failure: const NoInternetFailure());
    } on ServerException catch (e) {
      return (products: <ProductEntity>[], failure: ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return (products: <ProductEntity>[], failure: NetworkFailure(e.message));
    } catch (e) {
      return (products: <ProductEntity>[], failure: const UnknownFailure());
    }
  }
}

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider), ref.watch(connectivityCheckerProvider));
}
