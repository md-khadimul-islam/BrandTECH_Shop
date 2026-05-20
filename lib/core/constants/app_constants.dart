class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Hive
  static const String favoritesBoxName = 'favorites_box';
  static const String themeBoxName = 'theme_box';
  static const String themeKey = 'is_dark_mode';

  // UI
  static const double cardBorderRadius = 16.0;
  static const double pagePadding = 16.0;
  static const double imageHeight = 200.0;
}
