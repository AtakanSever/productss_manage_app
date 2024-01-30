import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

abstract class AppCache<T> {
  Future<void> addProduct({required T item});
  Future<List<Product>> getAllProducts();
  Future<bool> deleteProduct({required T item});
  Future<List<CartModel>> getAllCartProducts();
}

class AppCacheProducts extends AppCache<Product> {
  late Box<Product> _productsBox;

  AppCacheProducts() {
    _productsBox = Hive.box<Product>('products');
  }

  @override
  Future<void> addProduct({required Product item}) async {
    try {
      await _productsBox.put(item.id, item);
    } catch (e) {
      print('Bir hata oluştu $e');
    }
  }

  @override
  Future<bool> deleteProduct({required Product item}) async {
    await _productsBox.delete(item.id);
    return true;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    List<Product> _allProducts = _productsBox.values.toList();
    return _allProducts;
  }

  @override
  Future<List<CartModel>> getAllCartProducts() {
    throw UnimplementedError();
  }
}

class AppCacheCart extends AppCache<CartModel> {
  late Box<CartModel> _cartBox;

  AppCacheCart() {
    _cartBox = Hive.box<CartModel>('cart');
  }

  @override
  Future<void> addProduct({required CartModel item}) async {
    try {
      await _cartBox.put(item.id, item);
    } catch (e) {
      print('Bir hata oluştu $e');
    }
  }

  @override
  Future<bool> deleteProduct({required CartModel item}) async {
    await _cartBox.delete(item.id);
    return true;
  }

  @override
  Future<List<CartModel>> getAllCartProducts() async{
    List<CartModel> _allCartProducts = _cartBox.values.toList();
    return _allCartProducts;
  }

  @override
  Future<List<Product>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }
}
