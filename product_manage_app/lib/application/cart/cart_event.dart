import 'package:product_manage_app/domain/home/home_model.dart';

abstract class EventCart {}

class EventCartGetInfo extends EventCart {
  EventCartGetInfo();
}

class EventAddCart extends EventCart {
  final Product product;
  EventAddCart(this.product);
}
