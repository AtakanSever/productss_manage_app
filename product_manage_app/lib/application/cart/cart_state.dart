import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

abstract class StateCart {}

class StateCartInitialize extends StateCart {}

class StateCartFetching extends StateCart {}

class StateCartFetched extends StateCart {
  final List<Product> cartProductsList;
  final List<CartModel> cartProductsDetailList;
  final double totalPrice;

  StateCartFetched(this.cartProductsList, this.cartProductsDetailList, this.totalPrice);
}

class StateAddCart extends StateCart {
  final List<Product> cartProductsList;
  final List<CartModel> cartProductsDetailList;

  StateAddCart({
    required this.cartProductsList,
    required this.cartProductsDetailList,
  });
}

class StateDeleteProductCart extends StateCart {
  final List<Product> cartProductList;
  final List<CartModel> cartProductDetailList;

  StateDeleteProductCart({
    required this.cartProductList,
    required this.cartProductDetailList,
  });
}

class StateCartFail extends StateCart {
  final String errorMessage;

  StateCartFail(this.errorMessage);
}
