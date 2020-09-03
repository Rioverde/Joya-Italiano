import 'package:flutter/material.dart';

Color primaryColor = Color.fromRGBO(0, 1, 47, 1);
Color disabledState = Color.fromRGBO(0, 1, 47, 90);
Color iconPrimaryColor = Color.fromRGBO(255, 255, 50, 1);

ThemeData joyaTheme() {
  return ThemeData.dark().copyWith(
    accentColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
    primaryColor: primaryColor,
    cursorColor: primaryColor,
    inputDecorationTheme: inputDecorationhandler(),
  );
}

InputDecorationTheme inputDecorationhandler() {
  return InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintStyle: TextStyle(
      fontFamily: 'Ubuntu',
      color: Colors.grey.shade200,
    ),
    labelStyle: TextStyle(
      fontFamily: 'Ubuntu',
      color: primaryColor,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red, //this has no effect
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}
