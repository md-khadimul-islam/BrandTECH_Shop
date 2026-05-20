import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'products_provider.g.dart';

class ProductsState {
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final bool isLoading;
  final Failure? failure;
  final String searchQuery;
  final String selectedCategory;

  const ProductsState({
    this.products = const [],
    this.filteredProducts = const [],
    this.isLoading = false,
    this.failure,
    this.searchQuery = '',
    this.selectedCategory = 'All',
  });

  List<String> get categories {
    final cats = products.map((p) => p.category).toSet().toList()..sort();
    return ['All', ...cats];
  }

  ProductsState copyWith({
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    bool? isLoading,
    Failure? failure,
    bool clearFailure = false,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return ProductsState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isLoading: isLoading ?? this.isLoading,
      failure: clearFailure ? null : (failure ?? this.failure),
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  @override
  ProductsState build() {
    Future.microtask(fetchProducts);
    return const ProductsState(isLoading: true);
  }

  Future<void> fetchProducts() async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final useCase = ref.read(getProductsUseCaseProvider);
    final result = await useCase();
    if (result.failure != null) {
      state = state.copyWith(isLoading: false, failure: result.failure);
    } else {
      state = state.copyWith(
        isLoading: false,
        products: result.products,
        filteredProducts: result.products,
        clearFailure: true,
      );
    }
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = state.products;

    if (state.selectedCategory != 'All') {
      filtered = filtered.where((p) => p.category == state.selectedCategory).toList();
    }

    if (state.searchQuery.isNotEmpty) {
      final q = state.searchQuery.toLowerCase();
      filtered = filtered.where((p) => p.title.toLowerCase().contains(q)).toList();
    }

    state = state.copyWith(filteredProducts: filtered);
  }
}
