import 'package:flutter/material.dart';

class AppColors {
  static const Color mainColorSidigs = Color.fromRGBO(0, 154, 222, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 117, 176, 1);
  static const Color inactiveColor = Color.fromRGBO(133, 139, 166, 1);
  static const Color secondaryText = Color.fromRGBO(82, 103, 137, 1);
  static const Color mainText = Color.fromRGBO(4, 23, 53, 1);

  static const Color green = Color.fromRGBO(90, 175, 85, 1);

  static const List<BoxShadow> shadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      offset: Offset(0, 4),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> invertedShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      offset: Offset(0, -4),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const LinearGradient mainColorGradient = LinearGradient(
    colors: [
      Color.fromRGBO(28, 178, 255, 1),
      Color.fromRGBO(90, 199, 255, 1),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
