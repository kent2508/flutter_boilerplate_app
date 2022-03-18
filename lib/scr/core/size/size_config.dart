import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  static late double topSafeAreaPadding;
  static late double bottomSafeAreaPadding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    topSafeAreaPadding = _mediaQueryData.padding.top;
    bottomSafeAreaPadding = _mediaQueryData.padding.bottom;
  }
}
