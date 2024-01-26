import 'package:flutter/material.dart';
import 'package:product_manage_app/presentation/pages/cart/cart_page.dart';
import 'package:product_manage_app/presentation/pages/home/home_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currenIndex = 0;

  final List<Widget> _pages = [HomePage(), const CartPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currenIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currenIndex,
          onTap: (index) {
            setState(() {
              currenIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              label: 'Sepet',
            ),
          ]),
    );
  }
}
