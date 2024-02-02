import 'package:product_manage_app/domain/home/home_model.dart';

class CartState {
  final bool isInProgress;
  final bool isUpdated;
  final bool isFailed;
  final List<Product> products;
  final double totalPrice;
  final double netMoney;
  final bool check;
  final double updateTotalPrice;

  CartState({
    this.isInProgress = false,
    this.isUpdated = false,
    this.isFailed = false,
    this.products = const [],
    this.totalPrice = 0,
    this.netMoney = 0,
    this.check = false,
    this.updateTotalPrice = 0,
  });

  CartState copyWith(
      {bool? isInProgress,
      bool? isUpdated,
      bool? isFailed,
      int? amount,
      List<Product>? products,
      double? totalPrice,
      double? netMoney,
      bool? check,
      double? updateTotalPrice}) {
    return CartState(
        isInProgress: isInProgress ?? this.isInProgress,
        isUpdated: isUpdated ?? this.isUpdated,
        isFailed: isFailed ?? this.isFailed,
        products: products ?? this.products,
        totalPrice: totalPrice ?? this.totalPrice,
        netMoney: netMoney ?? this.netMoney,
        check: check ?? this.check,
        updateTotalPrice: updateTotalPrice ?? this.updateTotalPrice);
  }
}
