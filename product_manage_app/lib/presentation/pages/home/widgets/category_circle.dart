import 'package:flutter/material.dart';
import 'package:product_manage_app/presentation/core/utility/app-strings_style.dart';

class CategoryCircle extends StatelessWidget {
  final function;
  final String categoryTitle;
  final String ImageUrl;
  const CategoryCircle(
      {super.key,
      this.function,
      required this.categoryTitle,
      required this.ImageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(ImageUrl))),
            ),
            const SizedBox(
              height: 3,
            ),
            Center(
                child: Text(
              categoryTitle,
              textAlign: TextAlign.center,
              style: AppStringStyle.categoryCircleTextStyle,
            )),
          ],
        ),
      ),
    );
  }
}
