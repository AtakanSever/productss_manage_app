import 'package:flutter/material.dart';

class CategoryCircle extends StatelessWidget {
  final function;
  final String categoryTitle;
  const CategoryCircle({super.key, this.function, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300,
          width: 100,
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: Center(
              child: Text(
            categoryTitle,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
