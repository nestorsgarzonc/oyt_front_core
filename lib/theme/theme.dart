import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData myTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.deepOrange,
      listTileTheme: const ListTileThemeData(
        minLeadingWidth: 5,
        horizontalTitleGap: 8,
      ),
      appBarTheme: const AppBarTheme(
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

  // [TEXT STYLES]
  static const sectionTitleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
  static const selectedItemTextStyle =
      TextStyle(fontWeight: FontWeight.w600, color: Colors.deepOrange);
  // [BOX DECORATIONS]
  static const drawerBoxDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
  );
  static const roundedBoxDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
  // [PADDINGS]
  static const drawerBodyPadding = EdgeInsets.symmetric(horizontal: 20);
  static const dialogPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 15);
  static const cardMargin = EdgeInsets.symmetric(vertical: 5);
  // [COLORS]
  static const greyColor = Color(0xff67727d);
  static final redColor = Colors.red[700];
}
