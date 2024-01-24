import 'package:flutter/material.dart';

class CategoryCircle extends StatelessWidget {
  final function;
  const CategoryCircle({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
