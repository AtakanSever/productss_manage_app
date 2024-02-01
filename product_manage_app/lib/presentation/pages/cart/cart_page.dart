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
    return BlocBuilder<CartBloc, CartState>(builder: ((context, state) {
      if (state.isInProgress) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text('Sepet Kısmı'),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ara Toplam: ',
                              style: AppStringStyle.totalPriceDescriptionStyle,
                            ),
                            Text(
                              state.totalPrice.toString(),
                              style: AppStringStyle.totalPriceStyle,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Toplam NetPara: ',
                              style: AppStringStyle.totalPriceDescriptionStyle,
                            ),
                            Text(
                              state.netMoney.toStringAsFixed(2),
                              style: AppStringStyle.totalPriceStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: ((context, index) {
                      var product = state.products[index];
                      return SizedBox(
                        height: 120,
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.network(product.image!),
                                title: Text(
                                  product.title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                subtitle: Row(
                                  children: [
                                    Text('Miktar: ${product.amount}'),
                                    Text('Ürün Puanı: ${product.rating}'),
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context)
                                          .add(EventDeleteProductCart(product));
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ),
                              Text(
                                product.price.toString(),
                                style: AppStringStyle.productListPriceStyle,
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ],
          ));
    }));
  }
}
