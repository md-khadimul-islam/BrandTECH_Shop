import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../data/datasources/favorites_local_datasource.dart';
import '../../domain/repositories/favorites_repository.dart';

part 'favorites_repository_impl.g.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _localDataSource;

  const FavoritesRepositoryImpl(this._localDataSource);

  @override
  List<ProductEntity> getFavorites() => _localDataSource.getFavorites();

  @override
  Future<void> addFavorite(ProductEntity product) =>
      _localDataSource.addFavorite(product);

  @override
  Future<void> removeFavorite(int productId) =>
      _localDataSource.removeFavorite(productId);

  @override
  bool isFavorite(int productId) => _localDataSource.isFavorite(productId);
}

@riverpod
FavoritesRepository favoritesRepository(Ref ref) {
  return FavoritesRepositoryImpl(ref.watch(favoritesLocalDataSourceProvider));
}
