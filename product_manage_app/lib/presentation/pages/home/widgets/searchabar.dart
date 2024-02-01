import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  TextEditingController controller;
  List productCategoryList;
  SearchBarWidget({super.key, required this.controller, required this.productCategoryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
            label: Text('Ürünü Ara'), border: OutlineInputBorder()),
        controller: controller,
        onChanged: (value) {
          value = controller.text;
          for(String category in productCategoryList) {
            for(int i = 0; i < category.length; i++) {
              
            }
          }
        },
      ),
    );
  }
}
