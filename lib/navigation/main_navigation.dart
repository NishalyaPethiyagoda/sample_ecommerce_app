import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';
import 'package:sample_ecommerce_app/screens/cart/view/cart_screen.dart';
import 'package:sample_ecommerce_app/screens/home/view/home_screen.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    if(index == 1 && Provider.of<CartProvider>(context, listen: false).cartItemsList.isEmpty){
        return;
      }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: Color.fromARGB(255, 255, 249, 246),        
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFFFA726),
        unselectedItemColor: const Color.fromARGB(255, 131, 131, 131), 
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}