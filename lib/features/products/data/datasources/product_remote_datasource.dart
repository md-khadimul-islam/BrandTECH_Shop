import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/product_model.dart';

part 'product_remote_datasource.g.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio _dio;

  const ProductRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(AppConstants.productsEndpoint);
      final data = response.data as List<dynamic>;
      return data.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        throw const NoInternetException();
      }
      if (e.error is ServerException) {
        throw e.error as ServerException;
      }
      throw NetworkException(e.message ?? 'Network error');
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}

@riverpod
ProductRemoteDataSource productRemoteDataSource(Ref ref) {
  return ProductRemoteDataSourceImpl(ref.watch(dioClientProvider));
}
