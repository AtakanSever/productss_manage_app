import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_bloc.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/product_of_categories/product_of_categories_bloc.dart';
import 'package:product_manage_app/infrastructure/cart/cart_services.dart';
import 'package:product_manage_app/infrastructure/home/home_services.dart';
import 'package:product_manage_app/presentation/pages/home/home_page.dart';
import 'package:product_manage_app/presentation/pages/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(ProductsService(),CartServices())),
        BlocProvider<CartBloc>(
            create: (context) => CartBloc(CartServices(), ProductsService())),
        BlocProvider(create: (context) => ProductOfCategoriesBloc(ProductsService(), CartServices()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Navbar(),
      ),
    );
  }
}
