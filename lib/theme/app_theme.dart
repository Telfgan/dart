import 'package:flutter/material.dart';

final ThemeData mainTheme = _mainTheme();

ThemeData _mainTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: const Color.fromRGBO(3, 158, 162, 1),
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 9, 117, 121),
      onSecondary: Colors.white,
      background: Color.fromARGB(255, 165, 198, 159),
      onBackground: Colors.black,
    ),
    textTheme: _mainTextTheme(base.textTheme),
    elevatedButtonTheme: _elevatedButtonTheme(base.elevatedButtonTheme),
  );
}

TextTheme _mainTextTheme(TextTheme base) => base.copyWith(
      headline1: base.headline1!.copyWith(
          fontFamily: "Roboto",
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.white),

      headline2: base.headline1!.copyWith(
          fontFamily: "Roboto",
          fontSize: 26,
          fontWeight: FontWeight.w400,
          color: Colors.white),

      headline3: base.headline1!.copyWith(
          fontFamily: "Roboto",
          fontSize: 24,
          fontWeight: FontWeight.w300,
          color: Colors.white),

      // for widgets contents/paragraph
      bodyText1: base.bodyText1!.copyWith(
          fontFamily: "Roboto",
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Colors.white),
// for sub-widgets contents/paragraph
      bodyText2: base.bodyText2!.copyWith(
          fontFamily: "Roboto",
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.white),
    );

ElevatedButtonThemeData _elevatedButtonTheme(ElevatedButtonThemeData base) =>
    ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 129, 193, 99),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );

InputDecorationTheme _inputDecorationTheme(InputDecorationTheme base) =>
    const InputDecorationTheme(
// Label color for the input widget
      labelStyle: TextStyle(color: Colors.black),
// Define border of input form while focused on
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
      ),
    );
