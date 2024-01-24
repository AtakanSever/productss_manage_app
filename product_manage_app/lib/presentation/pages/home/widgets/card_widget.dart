import 'package:flutter/material.dart';

class CarDWidget extends StatelessWidget {
  const CarDWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: 400,
        color: Colors.green,
      ),
    );
  }
}
