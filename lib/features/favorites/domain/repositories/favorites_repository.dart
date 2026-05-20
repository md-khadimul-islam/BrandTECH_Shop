import '../../../products/domain/entities/product_entity.dart';

abstract class FavoritesRepository {
  List<ProductEntity> getFavorites();
  Future<void> addFavorite(ProductEntity product);
  Future<void> removeFavorite(int productId);
  bool isFavorite(int productId);
}
