import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/home/home_event.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/home/home_model.dart';
import 'package:product_manage_app/presentation/pages/home/widgets/category_circle.dart';
import 'package:product_manage_app/presentation/pages/home/widgets/gridview_shape.dart';
import 'package:product_manage_app/presentation/pages/home/widgets/searchabar.dart';
import 'package:product_manage_app/presentation/pages/product_detail/product_detail_page.dart';
import 'package:product_manage_app/presentation/pages/product_of_categories/product_of_categories_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler'),
      ),
      body: BlocBuilder<HomeBloc, StateProduct>(
        builder: (context, state) {
          if (state is StateProductInitialize) {
            BlocProvider.of<HomeBloc>(context).add(EventProductGetInfo());
            return const Center(child: CircularProgressIndicator());
          } else if (state is StateProductInfoFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StateProductInfoFetched) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SearchBar(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoriesList.length,
                      itemBuilder: (context, index) {
                        var selectedCategory = state.categoriesList[index];
                        return CategoryCircle(
                          ImageUrl: state.categoryImageList[index],
                          categoryTitle: selectedCategory,
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductOfCatgories(
                                selectedCategory: selectedCategory,
                              ),
                            ));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepOrange,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: CarouselSlider(
                        items: state.mostExpensiveProducts,
                        options: CarouselOptions(
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayInterval: const Duration(seconds: 3),
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          autoPlay: true,
                          height: 200,
                          onPageChanged: (index, reason) {
                            setState(() {
                              myCurrentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: state.productList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 12.0,
                      ),
                      itemBuilder: (context, index) {
                        Product product = state.productList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                productItem: product,
                              ),
                            ));
                          },
                          child: GridviewShape(
                            imageUrl: product.image!,
                            productTitle: product.title!,
                            productPrice: product.price.toString(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
