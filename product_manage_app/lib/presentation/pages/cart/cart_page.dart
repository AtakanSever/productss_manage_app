import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_bloc.dart';
import 'package:product_manage_app/application/cart/cart_event.dart';
import 'package:product_manage_app/application/cart/cart_state.dart';
import 'package:product_manage_app/presentation/core/utility/app-strings_style.dart';

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
                  child: state.cartProductsList.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.cartProductsDetailList.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 130,
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    ListTile(
                                        leading: Image.network(state
                                            .cartProductsList[index].image!),
                                        title: Text(
                                          state.cartProductsList[index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                                'Miktar: ${state.cartProductsDetailList[index].products![0].quantity}'),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                'Ürün Puanı: ${state.cartProductsList[index].rating}')
                                          ],
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(EventDeleteProductCart(
                                                      state.cartProductsList[
                                                          index],
                                                      state.cartProductsDetailList[
                                                          index]));
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))),
                                    Text(
                                      '${state.cartProductsList[index].price}₺',
                                      style:
                                          AppStringStyle.productListPriceStyle,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text('Sepette ürün bulunmuyor'),
                        ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Container(
                //       height: 200,
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //           color: Colors.deepOrange),
                //       child: Text('Ara Toplam: ${state.totalPrice}')),
                // )
              ],
            );
          } else if (state is StateCartFail) {
            return Text('Hata oluştu: ${state.errorMessage}');
          } else {
            return Container();
          }
        }));
  }
}
