import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_bloc.dart';
import 'package:product_manage_app/application/cart/cart_event.dart';
import 'package:product_manage_app/domain/cart/cart_model.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

class AddCartButton extends StatelessWidget {
  final Product product;
  AddCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<CartBloc>(context).add(EventAddCart(
          product,
        ));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size(60, 40),
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(20))),
      child: const Text('Sepete Ekle'),
    );
  }
}
