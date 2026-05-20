// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductsNotifier)
final productsProvider = ProductsNotifierProvider._();

final class ProductsNotifierProvider
    extends $NotifierProvider<ProductsNotifier, ProductsState> {
  ProductsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productsNotifierHash();

  @$internal
  @override
  ProductsNotifier create() => ProductsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductsState>(value),
    );
  }
}

String _$productsNotifierHash() => r'adc74b390e8cc250a96cd1161ca3c9f5b44922a6';

abstract class _$ProductsNotifier extends $Notifier<ProductsState> {
  ProductsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProductsState, ProductsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ProductsState, ProductsState>,
        ProductsState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
