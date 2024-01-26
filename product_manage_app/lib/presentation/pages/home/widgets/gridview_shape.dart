import 'package:flutter/material.dart';

class GridviewShape extends StatelessWidget {
  final String imageUrl;
  final String productTitle;
  final String productPrice;
  const GridviewShape(
      {super.key,
      required this.imageUrl,
      required this.productTitle,
      required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.redAccent.shade100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            ),
            Text(productTitle),
            Text(productPrice)
          ],
        ),
      ),
    );
  }
}
