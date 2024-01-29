import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

abstract class StateProductOfCategories {}

class StateProductOfCategoriesInitialize extends StateProductOfCategories {}

class StateProductOfCategoriesFetching extends StateProductOfCategories {}

class StateProductOfCategoriesFetched extends StateProductOfCategories {
  final List<Product> filteredProducts;
  final List<CartModel> filteredCartProduct;

  StateProductOfCategoriesFetched(
    this.filteredProducts, this.filteredCartProduct
  );
}

class StateProductOfCategoriesFailed extends StateProductOfCategories {
  final String errorMessage;

  StateProductOfCategoriesFailed(this.errorMessage);
}
