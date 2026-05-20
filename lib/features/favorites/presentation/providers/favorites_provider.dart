import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../data/repositories/favorites_repository_impl.dart';

part 'favorites_provider.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  List<ProductEntity> build() {
    final repo = ref.watch(favoritesRepositoryProvider);
    return repo.getFavorites();
  }

  Future<void> toggleFavorite(ProductEntity product) async {
    final repo = ref.read(favoritesRepositoryProvider);
    if (repo.isFavorite(product.id)) {
      await repo.removeFavorite(product.id);
    } else {
      await repo.addFavorite(product);
    }
    state = repo.getFavorites();
  }

  bool isFavorite(int productId) {
    final repo = ref.read(favoritesRepositoryProvider);
    return repo.isFavorite(productId);
  }
}
