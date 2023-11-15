import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black;
        }
        return Colors.transparent;
      }),
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFFFAFAFA),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 1,
      hoverColor: Colors.black.withOpacity(0.8),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF737373),
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFFA3A3A3),
        )));
