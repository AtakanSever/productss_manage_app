import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/cart/cart_bloc.dart';
import 'package:product_manage_app/application/cart/cart_state.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/home/home_event.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/presentation/core/common_widgets/add_cart_button.dart';
import 'package:product_manage_app/presentation/core/utility/app-strings_style.dart';

class ProductDetail extends StatefulWidget {
  Product productItem;
  ProductDetail({super.key, required this.productItem});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<HomeBloc, StateProduct>(builder: (context, state) {
          if (state is StateProductInitialize) {
            BlocProvider.of<HomeBloc>(context).add(EventProductGetInfo());
            return const Center(child: CircularProgressIndicator());
          } else if (state is StateProductInfoFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StateProductInfoFetched) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(widget.productItem.image!),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.productItem.title!,
                          style: AppStringStyle.productDetailTitleStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Ürün Puanı:',
                              style: AppStringStyle
                                  .productDetailRatingDescriptionStyle,
                            ),
                            Text(
                              widget.productItem.rating.toString(),
                              style: AppStringStyle.productDetailRatingStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Ürün Açıklaması:'),
                        Text(widget.productItem.description!),
                        SizedBox(
                          height: 300,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    color: Colors.deepOrangeAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(widget.productItem.price.toString()),
                        AddCartButton(product: widget.productItem)
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        }));
  }
}
