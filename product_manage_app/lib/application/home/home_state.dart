import 'package:flutter/material.dart';
import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

abstract class StateProduct {}

class StateProductInitialize extends StateProduct {}

class StateProductInfoFetching extends StateProduct {}

class StateProductInfoFetched extends StateProduct {
  final List<Product> productList;
  final List<dynamic> categoriesList;
  final List<Widget> mostExpensiveProducts;
  final List<String> categoryImageList;
  final List<CartModel> cartProductList;

  StateProductInfoFetched(this.productList, this.categoriesList,
      this.mostExpensiveProducts, this.categoryImageList, this.cartProductList);
}

class StateProductFailed extends StateProduct {
  final String errorMessage;

  StateProductFailed(this.errorMessage);
}
