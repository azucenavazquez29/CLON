// Archivo de los temas en los colores para el chat
import 'package:flutter/material.dart';

final Color tecGreen = const Color(0xFF006D39);
final Color tecBlue = const Color(0xFF003A70);
final Color tecWhite = const Color(0xFFFFFFFF);

final ThemeData tecNMTheme = ThemeData(
  primaryColor: tecGreen,
  scaffoldBackgroundColor: const Color(0xFFF1F6F4),
  useMaterial3: true,

  appBarTheme: AppBarTheme(
    backgroundColor: tecBlue,
    foregroundColor: tecWhite,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: tecGreen,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: tecGreen, width: 1.3),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: tecBlue, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: tecBlue,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),

  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: tecGreen,
    secondary: tecBlue,
  ),
);
