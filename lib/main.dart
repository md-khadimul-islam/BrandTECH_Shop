import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/services/snackbar_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/products/data/models/product_model.dart';
import 'features/products/data/models/product_model_adaptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(RatingModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());

  await Hive.openBox<ProductModel>(AppConstants.favoritesBoxName);
  await Hive.openBox(AppConstants.themeBoxName);

  runApp(const ProviderScope(child: BrandTechApp()));
}

class BrandTechApp extends ConsumerWidget {
  const BrandTechApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'BrandTECH Shop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      scaffoldMessengerKey: SnackbarService.messengerKey,
      routerConfig: router,
    );
  }
}
