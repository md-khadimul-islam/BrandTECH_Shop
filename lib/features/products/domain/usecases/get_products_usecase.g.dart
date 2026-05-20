// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getProductsUseCase)
final getProductsUseCaseProvider = GetProductsUseCaseProvider._();

final class GetProductsUseCaseProvider extends $FunctionalProvider<
    GetProductsUseCase,
    GetProductsUseCase,
    GetProductsUseCase> with $Provider<GetProductsUseCase> {
  GetProductsUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getProductsUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getProductsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetProductsUseCase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetProductsUseCase create(Ref ref) {
    return getProductsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProductsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProductsUseCase>(value),
    );
  }
}

String _$getProductsUseCaseHash() =>
    r'c92e1386fca8a39c22cd33333f5ef8f23f082ac9';
