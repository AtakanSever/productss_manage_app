import 'dart:convert';

import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:http/http.dart' as http;

class CartServices {
  Future<List<CartModel>?> getCartInfo() async {
    const String baseUrl = 'https://fakestoreapi.com/carts?userId=1';
    var url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<CartModel> cartProductList =
            jsonList.map((json) => CartModel.fromJson(json)).toList();
        return cartProductList;
      } else {
        throw Exception('Servisteki veriler getirilemedi');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
