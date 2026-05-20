import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/favorites/presentation/screens/favorite_screen.dart';
import '../../features/products/domain/entities/product_entity.dart';
import '../../features/products/presentation/screens/home_screen.dart';
import '../../features/products/presentation/screens/product_details_screen.dart';

part 'app_router.g.dart';

enum AppRoute { home, productDetail, favorites }

extension AppRouteExtension on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.home:
        return '/';
      case AppRoute.productDetail:
        return '/product/:id';
      case AppRoute.favorites:
        return '/favorites';
    }
  }

  String get name {
    switch (this) {
      case AppRoute.home:
        return 'home';
      case AppRoute.productDetail:
        return 'product-detail';
      case AppRoute.favorites:
        return 'favorites';
    }
  }
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoute.home.path,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        pageBuilder: (context, state) => CustomTransitionPage(key: state.pageKey, child: const HomeScreen(), transitionsBuilder: _fadeTransition),
      ),
      GoRoute(
        path: AppRoute.productDetail.path,
        name: AppRoute.productDetail.name,
        pageBuilder: (context, state) {
          final product = state.extra as ProductEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ProductDetailScreen(product: product),
            transitionsBuilder: _slideTransition,
          );
        },
      ),
      GoRoute(
        path: AppRoute.favorites.path,
        name: AppRoute.favorites.name,
        pageBuilder: (context, state) =>
            CustomTransitionPage(key: state.pageKey, child: const FavoritesScreen(), transitionsBuilder: _slideTransition),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Route not found: ${state.uri}'),
            TextButton(onPressed: () => context.go('/'), child: const Text('Go Home')),
          ],
        ),
      ),
    ),
  );
}

Widget _fadeTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(opacity: animation, child: child);
}

Widget _slideTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
    child: child,
  );
}
