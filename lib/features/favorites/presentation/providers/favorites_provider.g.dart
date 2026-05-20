// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritesNotifier)
final favoritesProvider = FavoritesNotifierProvider._();

final class FavoritesNotifierProvider
    extends $NotifierProvider<FavoritesNotifier, List<ProductEntity>> {
  FavoritesNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favoritesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favoritesNotifierHash();

  @$internal
  @override
  FavoritesNotifier create() => FavoritesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ProductEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ProductEntity>>(value),
    );
  }
}

String _$favoritesNotifierHash() => r'2cf5662d4d5f2cc31f9e361ac6e34357bf2378d3';

abstract class _$FavoritesNotifier extends $Notifier<List<ProductEntity>> {
  List<ProductEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<ProductEntity>, List<ProductEntity>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<ProductEntity>, List<ProductEntity>>,
        List<ProductEntity>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
