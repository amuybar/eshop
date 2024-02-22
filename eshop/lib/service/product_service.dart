import 'dart:convert';
import 'package:eshop/service/model/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String apiUrl = 'http://localhost:3000/products';

  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
      
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
