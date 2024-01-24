import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manage_app/application/home/home_bloc.dart';
import 'package:product_manage_app/application/home/home_event.dart';
import 'package:product_manage_app/application/home/home_state.dart';
import 'package:product_manage_app/domain/home/home_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürünler'),
      ),
      body: BlocBuilder<HomeBloc, StateProduct>(
        builder: (context, state) {
          if (state is StateProductInitialize) {
            BlocProvider.of<HomeBloc>(context).add(EventProductGetInfo());
            return Center(child: CircularProgressIndicator());
          } else if (state is StateProductInfoFetching) {
            return Center(child: CircularProgressIndicator());
          } else if (state is StateProductInfoFetched) {
            return ListView.builder(
              itemCount: state.productList.length,
              itemBuilder: (context, index) {
                Product product = state.productList[index];
                return ListTile(
                  leading: Image.network(product.image!),
                  title: Text(product.title!),
                  subtitle: Text(product.description!),
                );
              },
            );
          } else if (state is StateProductFailed) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
