import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  //primaryColor: const Color(0xFFF8A435),
  primarySwatch: createMaterialColor(const Color(0xFFF8A435)),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color.fromARGB(255, 235, 235, 235),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      minimumSize: const Size(131, 52),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
      )
    ),
  ),
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
