import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_bloc.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
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
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(ProductsService())),
        BlocProvider<CartBloc>(create: (context) => CartBloc(CartServices(), ProductsService()))
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Navbar(),
        ),
    );
  }
}
