import 'package:flutter/material.dart';
import 'screens.dart';

class MainScreen extends StatefulWidget {
   
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final screens = const [HomeScreen(), CategoriesScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Principal'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categorías'),
        ],
        onTap: (index) {
          setState(() {_currentIndex = index;});
        },
      )
    );
  }
}