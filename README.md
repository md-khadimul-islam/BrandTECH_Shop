# BrandTECH Shop — Flutter App

A clean-architecture Flutter product listing app built for the BrandTECH Mobile Developer technical task.

## Screenshots

> Run the app and take screenshots to add here.

## Architecture

```
lib/
├── core/
│   ├── constants/       # App-wide constants & strings
│   ├── errors/          # Failures & exceptions
│   ├── network/         # Dio client & connectivity checker
│   ├── router/          # GoRouter configuration
│   ├── services/        # Snackbar configuration
│   └── theme/           # App themes (light/dark) & theme provider
│
└── features/
    ├── products/
    │   ├── data/
    │   │   ├── datasources/   # Remote API data source (Dio)
    │   │   ├── models/        # ProductModel (JSON + Hive adapter)
    │   │   └── repositories/  # ProductRepositoryImpl
    │   ├── domain/
    │   │   ├── entities/      # ProductEntity, RatingEntity
    │   │   ├── repositories/  # Abstract ProductRepository
    │   │   └── usecases/      # GetProductsUseCase
    │   └── presentation/
    │       ├── providers/     # ProductsNotifier (Riverpod)
    │       ├── screens/       # HomeScreen, ProductDetailScreen
    │       └── widgets/       # ProductCard, ShimmerGrid, ErrorState
    │
    └── favorites/
        ├── data/
        │   ├── datasources/   # FavoritesLocalDataSource (Hive)
        │   └── repositories/  # FavoritesRepositoryImpl
        ├── domain/
        │   ├── repositories/  # Abstract FavoritesRepository
        │   └── usecases/      # (via FavoritesNotifier)
        └── presentation/
            ├── providers/     # FavoritesNotifier (Riverpod)
            ├── screens/       # FavoritesScreen
            └── widgets/       # FavoriteItem
```

## Features

- **Home Screen** — Product grid with shimmer loading, search bar, category filter chips, pull-to-refresh
- **Product Detail** — Hero image animation, full info (image, title, description, price, category, rating), add/remove favorite
- **Favorites** — Persisted with Hive, swipe-to-dismiss, badge counter on home app bar
- **Dark Mode** — Toggle via app bar button, preference saved in Hive
- **Error Handling** — No-internet & server error states with retry button
- **Smooth Navigation** — GoRouter with custom slide/fade transitions

## Libraries Used

| Library | Purpose |
|---|---|
| `flutter_riverpod` + `riverpod_annotation` | State management |
| `go_router` | Navigation & routing |
| `hive_flutter` + `hive` | Local favorites persistence |
| `dio` | HTTP client |
| `connectivity_plus` | Internet connectivity check |
| `cached_network_image` | Efficient image loading & caching |
| `flutter_rating_bar` | Star rating display |
| `shimmer` | Loading skeleton effect |
| `equatable` | Value equality for entities |

## Setup & Run

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/md-khadimul-islam/BrandTECH_Shop.git
cd BrandTECH_Shop

# 2. Install dependencies
flutter pub get

# 3. Run build_runner to regenerate code (if needed)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Run on specific platform
```bash
flutter run -d android   # Android
flutter run -d ios       # iOS
flutter run -d chrome    # Web
```

## API

This app uses the public [FakeStore API](https://fakestoreapi.com/products) — no authentication required.

## Notes

- All `.g.dart` files are pre-generated and committed to the repo for convenience.
- To regenerate: `flutter pub run build_runner build --delete-conflicting-outputs`
