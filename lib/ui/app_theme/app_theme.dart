import 'package:flutter/material.dart';

ThemeData appThemeLight = ThemeData(
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(),
      color: Color(0xfff4f4f4),
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    primaryColor: Color(0xff617ADC),
    highlightColor: Color.fromARGB(255, 45, 191, 195),
    accentColor: Color(0xff219653),
    primaryColorLight: Colors.white,
    primaryColorDark: Color(0xff333333),
    backgroundColor: Color(0xfafafafa),
    buttonColor: Color(0xffF2994A),
    hintColor: Color(0xff777777),
    textTheme: TextTheme(
      headline1: TextStyle().copyWith(fontFamily: 'Segoe'),
      headline2: TextStyle().copyWith(fontFamily: 'Segoe'),
      headline4: TextStyle().copyWith(fontFamily: 'Segoe'),
      headline3: TextStyle().copyWith(fontFamily: 'Segoe'),
      bodyText2: TextStyle().copyWith(fontFamily: 'Segoe'),
      bodyText1: TextStyle().copyWith(fontFamily: 'Segoe'),
      headline5: TextStyle().copyWith(fontFamily: 'Segoe'),
      headline6: TextStyle().copyWith(fontFamily: 'Segoe'),
      caption: TextStyle().copyWith(fontFamily: 'Segoe'),
      button: TextStyle().copyWith(fontFamily: 'Segoe'),
    ));
