import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

double getSize(double size, BuildContext context) {
  double nSize = size;
  // double nSize = 14;
  double width = MediaQuery.of(context).size.width;
  // print(
  //     "your device width is $width and ${MediaQuery.of(context).size.shortestSide}");
  if (width <= 320) {
    nSize = size * 0.65;
  } else if (width > 320 && width <= 375) {
    nSize = size * 0.75;
  } else if (width > 375 && width < 480) {
    nSize = size * 0.85;
  } else if (width > 500 && width < 900) {
    nSize = size * 1.1;
  } else {
    nSize = size * 1.1;
  }
  return nSize;
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  void init(BuildContext context) {
    var physicalSize = ui.window.physicalSize;
    var devicePixelRatio = ui.window.devicePixelRatio;

    // Calculate the logical size (standard size)
    var width = physicalSize.width / devicePixelRatio;
    var height = physicalSize.height / devicePixelRatio;

    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
