import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class AppImages {
  static String imageExt(String path) => "assets/images/$path";
  static String get splash => imageExt("splash.webp");
  static String get noInternet => imageExt("noInternet.png");
  static String get error => imageExt("error.png");
}
