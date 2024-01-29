import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_bloc.dart';
import 'package:product_manage_app/application/cart/cart_event.dart';
import 'package:product_manage_app/application/cart/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sepetim')),
        body: BlocBuilder<CartBloc, StateCart>(builder: (context, state) {
          if (state is StateCartInitialize) {
            BlocProvider.of<CartBloc>(context).add(EventCartGetInfo());
            return const Center(child: CircularProgressIndicator());
          } else if (state is StateCartFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StateCartFetched) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: state.cartProductsDetailList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                              state.cartProductsList[index].image!),
                          title: Text(
                              'Miktar: ${state.cartProductsDetailList[index].products![0].quantity}'),
                        );
                      }),
                )
              ],
            );
          } else if (state is StateCartFail) {
            // Hata durumu, kullanıcıya bir hata mesajı gösterilebilir.
            return Text('Hata oluştu: ${state.errorMessage}');
          } else {
            // Diğer durumlar için Container gösterilebilir.
            return Container();
          }
        }));
  }
}
