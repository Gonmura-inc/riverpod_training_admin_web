import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  //フォームのデザイン
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: Colors.white,
    useIndicator: true,
    indicatorColor: Colors.blue,
    selectedIconTheme: IconThemeData(color: Colors.white),
    unselectedIconTheme: IconThemeData(color: Colors.blue),
    selectedLabelTextStyle: TextStyle(color: Colors.blue),
    unselectedLabelTextStyle: TextStyle(color: Colors.black),
    minExtendedWidth: 240,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 14),
    hintStyle: TextStyle(fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  //ボタン
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    minimumSize: const Size(800, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  )),
);
