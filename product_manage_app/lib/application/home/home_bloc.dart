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
      if (productList != null && productList.isNotEmpty) {
        emit(StateProductInfoFetched(productList));
      } else {
        emit(StateProductFailed('Ürün bilgisi alınamadı'));
      }
    } catch (e) {
      emit(StateProductFailed(e.toString()));
    }
  }
}

