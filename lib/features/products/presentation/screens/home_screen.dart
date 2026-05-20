import 'package:brandtech_shop/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/products_shimmer_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsProvider);
    final theme = Theme.of(context);
    final favCount = ref.watch(favoritesProvider).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () => context.pushNamed(AppRoute.favorites.name),
                icon: const Icon(Icons.favorite_rounded),
                tooltip: 'Favorites',
              ),
              if (favCount > 0)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        favCount > 9 ? '9+' : '$favCount',
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () => ref.read(themeProvider.notifier).toggle(),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                ref.watch(themeProvider) == ThemeMode.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(ref.watch(themeProvider)),
              ),
            ),
            tooltip: 'Toggle theme',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => ref.read(productsProvider.notifier).search(v),
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(productsProvider.notifier).search('');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Category section
          if (state.categories.length > 1)
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = state.categories[index];
                  final isSelected = state.selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(
                      cat.capitalizeFirst,
                    ),
                    selected: isSelected,
                    onSelected: (_) => ref.read(productsProvider.notifier).selectCategory(cat),
                  );
                },
              ),
            ),
          const SizedBox(height: 8),

          Expanded(
            child: _buildBody(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProductsState state) {
    if (state.isLoading) {
      return const ProductsShimmerGrid();
    }

    if (state.failure != null) {
      return ErrorStateWidget(
        failure: state.failure!,
        onRetry: () => ref.read(productsProvider.notifier).fetchProducts(),
      );
    }

    if (state.filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noProductsFound,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(productsProvider.notifier).fetchProducts(),
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.59,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: state.filteredProducts.length,
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300 + (index * 50).clamp(0, 500)),
            child: ProductCard(product: state.filteredProducts[index]),
          );
        },
      ),
    );
  }
}
