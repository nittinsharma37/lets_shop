import 'package:dio/dio.dart';
import 'package:lets_shop/model/product_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('/products');
      print(response.toString());
      List<Product> products = (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
      return products;
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}
