import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_event.dart';
import 'package:product_manage_app/application/cart/cart_state.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/infrastructure/cart/cart_services.dart';
import 'package:product_manage_app/infrastructure/home/home_services.dart';
import 'package:product_manage_app/presentation/core/database/app_cache.dart';

class CartBloc extends Bloc<EventCart, StateCart> {
  final CartServices cartService;
  final ProductsService productService;
  List<Product> matchedProducts = [];
  List<CartModel> metchedCartProducts = [];
  List<CartModel> filteredProducts = [];
  late AppCache _appcacheProduct;
  late AppCache _appcacheCart;
  double totalPrice = 0.0;

  CartBloc(this.cartService, this.productService)
      : super(StateCartInitialize()) {
    _appcacheProduct = AppCacheProducts();
    _appcacheCart = AppCacheCart();
    on<EventCartGetInfo>(_getCartInfo);
    on<EventAddCart>(_addCartProduct);
    on<EventDeleteProductCart>(_deleteProductCart);
  }

  void addCartProduct(Product product, CartModel cartProduct) {
    matchedProducts.add(product);
    metchedCartProducts.add(cartProduct);

    emit(StateAddCart(
      cartProductsList: matchedProducts.toList(),
      cartProductsDetailList: metchedCartProducts.toList(),
    ));
  }

  void _addCartProduct(EventAddCart event, emit) {
    Product product = event.product;
    CartModel cartProduct = event.cartProduct;

    addCartProduct(product, cartProduct);
    emit(StateCartFetched(
      matchedProducts.toList(),
      metchedCartProducts.toList(),
      totalPrice
    ));
    _appcacheProduct.addProduct(item: event.product);
    _appcacheCart.addProduct(item: event.cartProduct);
  }

  void deleteProductCart(Product product, CartModel cartProduct) {
    matchedProducts.remove(product);
    metchedCartProducts.remove(cartProduct);

    emit(StateDeleteProductCart(
        cartProductList: matchedProducts.toList(),
        cartProductDetailList: metchedCartProducts.toList()));
  }

  void _deleteProductCart(EventDeleteProductCart event, emit) {
    Product product = event.product;
    CartModel cartProduct = event.cartProduct;

    deleteProductCart(product, cartProduct);
    emit(StateCartFetched(
      matchedProducts.toList(),
      metchedCartProducts.toList(),
      totalPrice

    ));
    _appcacheProduct.deleteProduct(item: event.product);
    _appcacheCart.deleteProduct(item: event.cartProduct);
  }

  Future<void> _getCartInfo(EventCartGetInfo event, emit) async {
    emit(StateCartFetching());
    try {
      final List<CartModel>? cartList = await cartService.getCartInfo();
      final List<Product>? productList = await productService.getProductInfo();

      if (cartList != null && cartList.isNotEmpty && productList != null) {
        for (var cartItem in cartList) {
          for (var productItem in cartItem.products ?? []) {
            if (cartItem.id == 1) {
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
                    products: [
                      Products(
                          productId: metchedCartProduct.id,
                          quantity: productItem.quantity)
                    ],
                    iV: cartItem.iV));
              }
            }
          }
        }
        List<Product> storedProductList =
            await _appcacheProduct.getAllProducts();
        List<CartModel> storedCartList =
            await _appcacheCart.getAllCartProducts();

        matchedProducts = storedProductList;
        metchedCartProducts = storedCartList;

        for (var product in matchedProducts) {
          totalPrice = totalPrice + product.price!;
        }

        emit(StateCartFetched(matchedProducts, metchedCartProducts, totalPrice));
      } else {
        emit(StateCartFail('Bir hata Oluştu'));
      }
    } catch (e) {
      emit(StateCartFail(e.toString()));
    }
  }
}
