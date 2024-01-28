import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/home/home_event.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/presentation/core/common_widgets/add_cart_button.dart';
import 'package:product_manage_app/presentation/core/utility/app-strings_style.dart';
import 'package:product_manage_app/presentation/pages/product_detail/product_detail_page.dart';

class ProductOfCatgories extends StatefulWidget {
  final String selectedCategory;
  const ProductOfCatgories({super.key, required this.selectedCategory});

  @override
  State<ProductOfCatgories> createState() => _ProductOfCatgoriesState();
}

class _ProductOfCatgoriesState extends State<ProductOfCatgories> {
  List<Product> filteredProducts = [];

  void _filterProducts(StateProduct state) {
    if (state is StateProductInfoFetched) {
      filteredProducts = state.productList
          .where((product) => product.category == widget.selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Of Categories'),
      ),
      body: BlocBuilder<HomeBloc, StateProduct>(builder: (context, state) {
        if (state is StateProductInitialize) {
          BlocProvider.of<HomeBloc>(context).add(EventProductGetInfo());
        } else if (state is StateProductInfoFetching) {
          return const CircularProgressIndicator();
        } else if (state is StateProductInfoFetched) {
          _filterProducts(state);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  productItem: filteredProducts[index])));
                        },
                        child: Card(
                          child: SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ListTile(
                                      leading: Image.network(
                                        filteredProducts[index].image!,
                                      ),
                                      title: Text(
                                        filteredProducts[index].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            'Ürün Puanı: ${filteredProducts[index].rating}',
                                            style: AppStringStyle
                                                .productOfCategoriesRatingStyle,
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${filteredProducts[index].price}₺',
                                          style: AppStringStyle
                                              .productOfCategoriesPriceStyle,
                                        ),
                                        AddCartButton(product: filteredProducts[index])
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    }),
              )
            ],
          );
        } else {
          return Container(
            child: const Text('Ürünler getirilemedi'),
          );
        }
        return Container();
      }),
    );
  }
}
