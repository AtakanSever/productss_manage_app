import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/product_of_categories/product_of_categories_event.dart';
import 'package:product_manage_app/application/product_of_categories/product_of_categories_state.dart';
import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/infrastructure/cart/cart_services.dart';
import 'package:product_manage_app/infrastructure/home/home_services.dart';

class ProductOfCategoriesBloc
    extends Bloc<EventProductOfCategories, StateProductOfCategories> {
  final ProductsService productService;
  final CartServices cartService;
  List<Product> filteredProducts = [];

  ProductOfCategoriesBloc(this.productService, this.cartService)
      : super(StateProductOfCategoriesInitialize()) {
    on<EventProductOfCategoriesGetInfo>(_getProductOfCategoriesInfo);
  }

  Future<void> _getProductOfCategoriesInfo(
      EventProductOfCategoriesGetInfo event, emit) async {
    final selectedCategory = event.selectedCategory;
    emit(StateProductOfCategoriesFetching());
    try {
      final List<Product>? productList = await productService.getProductInfo();
      final List<CartModel>? cartProductList = await cartService.getCartInfo();
      final List<String>? categoriesList =
          await productService.getCategoriesInfo();

      if (productList != null &&
          productList.isNotEmpty &&
          cartProductList != null &&
          cartProductList.isNotEmpty &&
          categoriesList != null &&
          categoriesList.isNotEmpty) {

            filteredProducts.clear();

          filteredProducts = productList
              .where((product) => product.category == selectedCategory)
              .toList();

        emit(StateProductOfCategoriesFetched(filteredProducts, cartProductList));
      }
    } catch (e) {}
  }
}
