import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_event.dart';
import 'package:product_manage_app/application/cart/cart_state.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/infrastructure/cart/cart_services.dart';
import 'package:product_manage_app/infrastructure/home/home_services.dart';

class CartBloc extends Bloc<EventCart, StateCart> {
  final CartServices cartService;
  final ProductsService productService;

  CartBloc(this.cartService, this.productService)
      : super(StateCartInitialize()) {
    on<EventCartGetInfo>(_getCartInfo);
  }

  Future<void> _getCartInfo(EventCartGetInfo event, emit) async {
    emit(StateCartFetching());
    try {
      final List<CartModel>? cartList = await cartService.getCartInfo();
      final List<Product>? productList = await productService.getProductInfo();

      if (cartList != null && cartList.isNotEmpty && productList != null) {
        List<Product> matchedProducts = [];
        List<CartModel> metchedCartProducts = [];

        for (var cartItem in cartList) {
          for (var productItem in cartItem.products ?? []) {
            final int? productId = productItem.productId;

            Product? matchedProduct = productList.firstWhere(
              (product) => product.id == productId,
            );

            Product? metchedCartProduct = productList
                .firstWhere((cartProduct) => cartProduct.id == productId);

            if (matchedProduct != null) {
              matchedProducts.add(matchedProduct);
              metchedCartProducts.add(CartModel(
                id: cartItem.id,
                userId: cartItem.userId,
                date: cartItem.date,
                products: [Products(productId: metchedCartProduct.id, quantity: productItem.quantity)],
                iV: cartItem.iV
              ));
            }
          }
        }

        emit(StateCartFetched(matchedProducts, metchedCartProducts));
      } else {
        emit(StateCartFail('Bir hata Oluştu'));
      }
    } catch (e) {
      emit(StateCartFail(e.toString()));
    }
  }
}
