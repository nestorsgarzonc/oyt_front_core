import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData myTheme() {
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static const dialogPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 15);
  static const drawerBoxDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
  );
  static final redColor = Colors.red[700];
  static const drawerBodyPadding = EdgeInsets.symmetric(horizontal: 20);
}
