// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData get defaultAppThemeData => ThemeData(
    fontFamily: AppFonts.textRegular,
    primarySwatch: materialPrimaryColor,
    hintColor: materialAccentColor,
useMaterial3: false,
    scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    appBarTheme: const AppBarTheme().copyWith(systemOverlayStyle:
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.light)),
    platform: TargetPlatform.android,
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white));

const MaterialColor materialPrimaryColor =  MaterialColor(
  0xffE20C37 ,
   <int, Color>{
    50:  Color(0xffE20C37),
    100:  Color(0xffE20C37 ),
    200:  Color(0xffE20C37 ),
    300:  Color(0xffE20C37 ),
    400:  Color(0xffE20C37 ),
    500:  Color(0xffE20C37 ),
    600:  Color(0xffE20C37 ),
    700:  Color(0xffE20C37 ),
    800:  Color(0xffE20C37 ),
    900:  Color(0xffE20C37 ),
  },
);

/*
* New colors added to make ui more clean
* */

const textColorPrimary = Color(0xFF444444);
const cboGrey = Color(0xFFF2F2F2);
const widgetViewColor = Color(0xFFEEEEF1);
const layout_background = Color(0xFFF6F7FA);
const dbShadowColor = Color(0x95E9EBF0);
const backgroundColor = Color(0xffFFEFE5);
Color get appIconTint_sky_blue => const Color(0xFF73d8d4);
Color get  appIconTint_mustard_yellow => const Color(0xFFffc980);
Color get  appIconTintDark_purple => const Color(0xFF8998ff);
Color get  appTxtTintDark_purple => const Color(0xFF515BBE);
const appIconTintDarkCherry = Color(0xFFf2866c);
Color get  appIconTintDark_sky_blue => const Color(0xFF73d8d4);
Color get  appDark_parrot_green => const Color(0xFF5BC136);
const appDarkRed = Color(0xFFF06263);
const appLightRed = Color(0xFFF89B9D);
const bluePurple = Color(0xFF8998FE);
const catOrange = Color(0xFFFF9781);
const greenBlue = Color(0xFF73D7D3);
const skyBlue = Color(0xFF87CEFA);

Color get primaryColor => materialPrimaryColor;

Color get primaryRed => Colors.red;

Color get primaryRed20 => Colors.red.shade200;

Color get primaryRed40 => Colors.red.shade400;

Color get primaryRed60 => Colors.red.shade600;

// Color get materialAccentColor => Color(0xffFDC800);
Color get materialAccentColor =>  Color(0xffE20C37);
//from old app
// Color get materialAccentColor => Color(0xff267b1b);

Color get textBlueDark => const Color(0xff3051A0);

Color get categoryIconCyan => const Color(0xff1bbef9);

Color get categoryTitleGrayDark => const Color(0xff707070);

Color get categoryCardBg => const Color(0xffe6ecf2);

Color get lightDividerColor => Colors.grey.shade200;

Color get borderSideColor => Colors.black26;

Color get borderSideFocusedColor => primaryColor;

Color get lightGrey50 => Colors.grey.shade50;

Color get whiteColor => Colors.white;

MaterialColor get randomColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];

abstract class AppFonts {
  static String  textRegular = 'textRegular';
  static String  textBold = 'textBold';
  static String  textSemiBold = 'textSemiBold';
}
