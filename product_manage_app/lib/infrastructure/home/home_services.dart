import 'dart:convert';

import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:http/http.dart' as http;

class ProductsService {
  Future<List<Product>?> getProductInfo() async {
    const String baseUrl = 'https://fakestoreapi.com/products';

    var url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<Product> productList =
            jsonList.map((json) => Product.fromJson(json)).toList();

        return productList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<String>?> getCategoriesInfo() async {
    const String baseUrl = 'https://fakestoreapi.com/products/categories';
    var url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonCategoriesList = json.decode(response.body);
        final List<String> categoriesList =
            jsonCategoriesList.map((category) => category.toString()).toList();
        return categoriesList;
      } else {
        throw Exception('Kategoriler alınamadı');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
