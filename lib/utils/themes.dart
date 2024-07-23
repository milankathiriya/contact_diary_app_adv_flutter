import 'package:flutter/material.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Colors.red, fontSize: 38),
    ),
    // primarySwatch: Colors.purple,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    ),
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.red,
    //   foregroundColor: Colors.white,
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amber,
      brightness: Brightness.dark,
    ),
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.teal,
    //   foregroundColor: Colors.black,
    // ),
  );
}
