import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme= ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      hintStyle: TextStyle(
        color: Colors.white,
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
      ),
      iconColor: Colors.white10,
    ),
    primaryColor: defaultColor,
    primarySwatch:defaultColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    //colorSchemeSeed: Colors.black,
    scaffoldBackgroundColor: Colors.black54,
    //brightness: Brightness.dark,
    //fontFamily: 'Anton',
    textTheme:   const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      titleMedium: TextStyle(
          color:Colors.white,
          fontSize: 18,
        ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(
        color: Colors.white54,
      ),
      backgroundColor: Colors.black54,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black54,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elevation: 30,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 30,
      backgroundColor: Colors.black54,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
    ),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: Colors.deepOrange,
    // ),
    fontFamily: 'hussein'
);
ThemeData lightTheme=ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.black45,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.black54
      ),
    ),
    iconColor: Colors.black54,
  ),
  primaryColor: Colors.teal,
  primarySwatch:Colors.teal,
  //colorSchemeSeed: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  //brightness: Brightness.dark,
  //fontFamily: 'Anton',
  textTheme:   const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 13,
    ),
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.black54,
    ),
    backgroundColor: Colors.teal,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white60,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 40,
    backgroundColor: Colors.white60,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  // floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //   backgroundColor: Colors.deepOrange,
  // ),
);