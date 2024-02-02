import 'package:flutter/foundation.dart';
import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

abstract class CartEvent {}

class EventGetProducts extends CartEvent {
  double netMoney;
  double totalPrice;
  double updateTotalPrice;
  EventGetProducts(this.netMoney, this.totalPrice, this.updateTotalPrice);
}

class EventAddCart extends CartEvent {
  final Product product;
  int amount;
  EventAddCart(this.product, {this.amount = 0});
}

class EventDeleteProductCart extends CartEvent {
  final Product product;

  EventDeleteProductCart(this.product);
}

class EventGetTotalPrice extends CartEvent {
  final Product product;
  EventGetTotalPrice(this.product);
}

class EventCategoryRatio extends CartEvent {
  final Product product;
  EventCategoryRatio(
    this.product,
  );
}

class EventUseNetMoney extends CartEvent {
  EventUseNetMoney();
}
