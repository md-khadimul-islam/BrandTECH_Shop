import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/domain/entities/product_entity.dart';

part 'favorites_local_datasource.g.dart';

abstract class FavoritesLocalDataSource {
  List<ProductEntity> getFavorites();
  Future<void> addFavorite(ProductEntity product);
  Future<void> removeFavorite(int productId);
  bool isFavorite(int productId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<ProductModel> _box;

  FavoritesLocalDataSourceImpl(this._box);

  @override
  List<ProductEntity> getFavorites() {
    return _box.values.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addFavorite(ProductEntity product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await _box.put(product.id.toString(), model);
    } catch (e) {
      throw CacheException('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(int productId) async {
    try {
      await _box.delete(productId.toString());
    } catch (e) {
      throw CacheException('Failed to remove favorite: $e');
    }
  }

  @override
  bool isFavorite(int productId) {
    return _box.containsKey(productId.toString());
  }
}

@riverpod
FavoritesLocalDataSource favoritesLocalDataSource(Ref ref) {
  final box = Hive.box<ProductModel>(AppConstants.favoritesBoxName);
  return FavoritesLocalDataSourceImpl(box);
}
