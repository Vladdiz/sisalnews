import 'package:flutter/material.dart';

Color primaryColor = const Color.fromARGB(255, 0, 100, 58);
Color secondaryColor = const Color.fromARGB(255, 185, 213, 49);
Color backgroundColor = const Color.fromARGB(255, 245, 245, 245);

final double minPadding = 8;
final double mediumPadding = 16;
final double maxPadding = 18;

final ThemeData appTheme = ThemeData(
  cardTheme: CardTheme(color: Colors.white),
  appBarTheme: AppBarTheme(color: primaryColor, foregroundColor: Colors.white),
  colorScheme: ColorScheme.fromSeed(
    surface: backgroundColor,
    secondary: secondaryColor,
    seedColor: primaryColor,
    primary: primaryColor,
  ),
  useMaterial3: true,
);
