import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/home/home_event.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/infrastructure/home/home_services.dart';

class HomeBloc extends Bloc<EventProduct, StateProduct> {
  final ProductsService productsService;

  HomeBloc(this.productsService) : super(StateProductInitialize()) {
    on<EventProductGetInfo>(_getProductInfo);
  }

  Future<void> _getProductInfo(EventProductGetInfo event, emit) async {
    emit(StateProductInfoFetching());
    try {
      final List<Product>? productList = await productsService.getProductInfo();
      final List<dynamic>? categoriesList =
          await productsService.getCategoriesInfo();
      if (productList != null &&
          productList.isNotEmpty &&
          categoriesList != null &&
          categoriesList.isNotEmpty) {
        productList.sort(
          (a, b) => b.price!.compareTo(a.price!),
        );
        List<Product> top3ProductsList = productList.take(3).toList();
        List<Widget> top3ProductListImage = top3ProductsList.map((product) {
          return Image.network(product.image!);
        }).toList();
        emit(
          StateProductInfoFetched(productList, categoriesList,
              top3ProductListImage),
        );
      } else {
        emit(StateProductFailed('Bir hata oluştu'));
      }
    } catch (e) {
      emit(StateProductFailed(e.toString()));
    }
  }
}
