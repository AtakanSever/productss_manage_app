import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_event.dart';
import 'package:product_manage_app/application/cart/cart_state.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/infrastructure/home/home_services.dart';
import 'package:product_manage_app/presentation/core/database/app_cache.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  late AppCache _appCache;
  CartBloc() : super(CartState()) {
    _appCache = AppCacheProducts();
    on<EventAddCart>(_onAddCartProduct);
    on<EventDeleteProductCart>(_onDeleteCartProduct);
    on<EventGetTotalPrice>(_onGetTotalPrice);
    on<EventCategoryRatio>(_onCategoryRatioTotalPrice);
    on<EventUseNetMoney>(_onUseNetMoney);
    on<EventGetProducts>(_onGetProducts);
  }
  late ProductsService _productsService = ProductsService();




  Future<void> _onGetProducts(
      EventGetProducts event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      isInProgress: true,
      isUpdated: false,
    ));
    List<Product> products = state.products;
    List<Product> newProducts = await _appCache.getAllProducts(products);

    emit(state.copyWith(
        isInProgress: false, isUpdated: true, products: newProducts,));
  }



  Future<void> _onAddCartProduct(
      EventAddCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      isInProgress: true,
      isUpdated: false,
    ));

    List<Product> updatedProducts = List.from(state.products)
      ..add(event.product);

    final selectedProduct = updatedProducts.firstWhere(
      (element) => element.id == event.product.id,
    );

    if (selectedProduct != null) {
      event.product.amount = selectedProduct.amount! + 1;
    } else {
      event.product.amount = 1;
    }

    Set<Product> updatedSetProduct = updatedProducts.toSet();
    List<Product> updatedProductList = updatedSetProduct.toList();

    emit(state.copyWith(
      isInProgress: false,
      isUpdated: true,
      products: updatedProductList,
    ));

    add(EventGetTotalPrice(selectedProduct));
    add(EventCategoryRatio(selectedProduct));
    add(EventUseNetMoney());
    _appCache.addProduct(item: event.product);
  }



  Future<void> _onDeleteCartProduct(
      EventDeleteProductCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      isInProgress: true,
      isUpdated: false,
    ));
    List<Product> updatedProducts = List.from(state.products)
      ..remove(event.product);

    emit(state.copyWith(
        isInProgress: false, isUpdated: true, products: updatedProducts));
    add(EventGetTotalPrice(event.product));
    add(EventCategoryRatio(event.product));
    add(EventUseNetMoney());
    _appCache.deleteProduct(item: event.product);
  }



  Future<void> _onGetTotalPrice(
      EventGetTotalPrice event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      isInProgress: true,
      isUpdated: false,
    ));

    double totalPrice = 0;
    for (var product in state.products) {
      totalPrice += product.amount! * product.price!;
    }

    emit(state.copyWith(
        isInProgress: false, isUpdated: true, totalPrice: totalPrice));
  }




  Future<void> _onCategoryRatioTotalPrice(
      EventCategoryRatio event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      isInProgress: true,
      isUpdated: false,
    ));
    double totalNetMoney = 0;

    for (var product in state.products) {
      if (product.category == "jewelery") {
        totalNetMoney += product.amount! * product.price! * 0.2;
      } else if (product.category == "electronics") {
        totalNetMoney += product.amount! * product.price! * 0.1;
      } else if (product.category == "men's clothing") {
        totalNetMoney += product.amount! * product.price! * 0.03;
      } else if (product.category == "women's clothing") {
        totalNetMoney += product.amount! * product.price! * 0.05;
      }
    }

    emit(state.copyWith(
      isInProgress: false,
      isUpdated: true,
      netMoney: totalNetMoney,
    ));
  }




  Future<void> _onUseNetMoney(
      EventUseNetMoney event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      isInProgress: true,
      isUpdated: false,
    ));

    double updateTotalPrice = 0;
    updateTotalPrice = state.totalPrice - (state.netMoney ?? 0);

    emit(state.copyWith(
      isInProgress: false,
      isUpdated: true,
      updateTotalPrice: updateTotalPrice,
    ));
  }
}
