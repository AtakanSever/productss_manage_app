import 'package:product_manage_app/domain/home/home_model.dart';

abstract class StateProduct {}

class StateProductInitialize extends StateProduct {}

class StateProductInfoFetching extends StateProduct {}

class StateProductInfoFetched extends StateProduct {
  final List<Product> productList;

  StateProductInfoFetched(this.productList);
}

class StateProductFailed extends StateProduct {
  final String errorMessage;

  StateProductFailed(this.errorMessage);
}
