import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/home/home_event.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

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
                  child: Column(
                    children: [
                      Image.network(widget.productItem.image!),
                      Text(widget.productItem.title!),
                      Text('Ürün Açıklaması:'),
                      Text(widget.productItem.description!)
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    color: Colors.deepOrange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(widget.productItem.price.toString()),
                        ElevatedButton(
                            onPressed: () {}, child: Text('sepete ekle'))
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        }));
  }
}
