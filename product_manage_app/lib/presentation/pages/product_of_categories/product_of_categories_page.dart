import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/product_of_categories/product_of_categories_bloc.dart';
import 'package:product_manage_app/application/product_of_categories/product_of_categories_event.dart';
import 'package:product_manage_app/application/product_of_categories/product_of_categories_state.dart';
import 'package:product_manage_app/presentation/core/utility/app-strings_style.dart';
import 'package:product_manage_app/presentation/pages/product_detail/product_detail_page.dart';

class ProductOfCatgories extends StatefulWidget {
  final String selectedCategory;
  const ProductOfCatgories({super.key, required this.selectedCategory});

  @override
  State<ProductOfCatgories> createState() => _ProductOfCatgoriesState();
}

class _ProductOfCatgoriesState extends State<ProductOfCatgories> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    BlocProvider.of<ProductOfCategoriesBloc>(context).add(
        EventProductOfCategoriesGetInfo(selectedCategory: selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Of Categories'),
      ),
      body: BlocBuilder<ProductOfCategoriesBloc, StateProductOfCategories>(
          builder: (context, state) {
        if (state is StateProductOfCategoriesInitialize) {
          BlocProvider.of<ProductOfCategoriesBloc>(context).add(
              EventProductOfCategoriesGetInfo(
                  selectedCategory: selectedCategory));
        } else if (state is StateProductOfCategoriesFetching) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is StateProductOfCategoriesFetched) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: state.filteredProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  productItem: state.filteredProducts[index],
                                  cartProduct: state.filteredCartProduct[index])));
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
                                      state.filteredProducts[index].image!,
                                    ),
                                    title: Text(
                                      state.filteredProducts[index].title!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${state.filteredProducts[index].price}₺',
                                          style: AppStringStyle
                                              .productOfCategoriesPriceStyle,
                                        ),
                                        Text(
                                          'Ürün Puanı: ${state.filteredProducts[index].rating}',
                                          style: AppStringStyle
                                              .productOfCategoriesRatingStyle,
                                        ),
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
