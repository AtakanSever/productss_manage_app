import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

abstract class EventCart {}

class EventCartGetInfo extends EventCart {
  EventCartGetInfo();
}

class EventAddCart extends EventCart {
  final Product product;
  final CartModel cartProduct;
  EventAddCart(this.product, this.cartProduct);
}

class EventDeleteProductCart extends EventCart {
  final Product product;
  final CartModel cartProduct;

  EventDeleteProductCart(this.product, this.cartProduct);
}
