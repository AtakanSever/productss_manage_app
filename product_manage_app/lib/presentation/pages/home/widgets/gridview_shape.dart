import 'package:flutter/material.dart';
import 'package:product_manage_app/presentation/core/utility/app-strings_style.dart';

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
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
            ),
            Text(
              productTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: AppStringStyle.productListTitleStyle,
            ),
            Text(
              productPrice + '₺',
              style: AppStringStyle.productListPriceStyle,
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
