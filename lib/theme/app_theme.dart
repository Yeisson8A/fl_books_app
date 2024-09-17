import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.blueGrey;
  static const Color secondary = Colors.black87;
  static const Color textColor = Colors.black87;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Color primario
    primaryColor: primary,
    // Tema del AppBar
    appBarTheme: const AppBarTheme(
      color: primary, 
      elevation: 0, 
      centerTitle: true, 
      titleTextStyle: TextStyle(fontSize: 25, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white)
    ),
    // Tema del BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primary,
      selectedItemColor: secondary,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(fontSize: 15),
      unselectedLabelStyle: TextStyle(fontSize: 13)
    )
  );

}