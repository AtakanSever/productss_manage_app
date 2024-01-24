import 'package:flutter/material.dart';

class GridviewShape extends StatelessWidget {
  const GridviewShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.redAccent.shade100),
    );
  }
}
