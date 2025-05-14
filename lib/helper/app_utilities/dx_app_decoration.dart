import 'package:flutter/material.dart';

import 'app_theme.dart';



class AppStyles {
  AppStyles._();

  static TextStyle getTextStyle(bool isSemiBold, double fontSize,
          {FontWeight fontWeight = FontWeight.w400,
          Color color = Colors.black}) =>
      new TextStyle(
          // fontFamily: AppFonts.textRegular,
          fontWeight: isSemiBold ? FontWeight.w500 : fontWeight,
          color: color,
          fontSize: fontSize,
          fontFamily:
              isSemiBold ? AppFonts.textSemiBold : AppFonts.textRegular);

  static TextStyle getTextStrikeThrough(bool isSemiBold, double fontSize,
          {Color textColor = Colors.black}) =>
      TextStyle(
          fontFamily: isSemiBold ? AppFonts.textSemiBold : AppFonts.textRegular,
          color: textColor,
          fontWeight: isSemiBold ? FontWeight.w500 : FontWeight.w400,
          fontSize: fontSize,
          decoration: TextDecoration.lineThrough);

  static TextStyle getTextStyleColor(bool isSemiBold, double fontSize,
          {Color textColor = Colors.black,
          FontWeight fontWeight = FontWeight.w400}) =>
      new TextStyle(
          // fontFamily: AppFonts.textRegular,
          fontWeight: isSemiBold ? FontWeight.w500 : fontWeight,
          color: textColor,
          fontSize: fontSize);

  static TextStyle getTextStylePrimary(bool isSemiBold, double fontSize) =>
      new TextStyle(
          fontFamily: AppFonts.textRegular,
          fontWeight: isSemiBold ? FontWeight.w500 : FontWeight.w400,
          color: materialPrimaryColor,
          fontSize: fontSize);

  static TextStyle getTextStyleGreen(bool isSemiBold, double fontSize) =>
      new TextStyle(
          fontFamily: AppFonts.textRegular,
          fontWeight: isSemiBold ? FontWeight.w800 : FontWeight.w500,
          color: Colors.green,
          fontSize: fontSize);

  static TextStyle getTextStyleRed(bool isSemiBold, double fontSize) =>
      new TextStyle(
          fontFamily: AppFonts.textRegular,
          fontWeight: isSemiBold ? FontWeight.w800 : FontWeight.w500,
          color: Colors.redAccent,
          fontSize: fontSize);

  static TextStyle getTextStyleWhite(bool isSemiBold, double fontSize) =>
      new TextStyle(
          fontFamily: AppFonts.textRegular,
          fontWeight: isSemiBold ? FontWeight.w800 : FontWeight.w500,
          color: Colors.white,
          fontSize: fontSize);

  static TextStyle getTextStyleDefaultColor(bool isSemiBold, double fontSize) =>
      new TextStyle(
          // fontFamily: App/Fonts.textRegular,
          fontWeight: isSemiBold ? FontWeight.w800 : FontWeight.w500,
          fontSize: fontSize);
}

//--------------------- Experimental --------------------------
const food_ShadowColor = Color(0X95E9EBF0);
const food_color_gray = Color(0xFFFAFAFA);
const food_ShadowColors = Color(0XFFE2E2E2);

BoxDecoration gradientBoxDecoration(
    {double radius = 8.0,
    Color color = Colors.transparent,
    Color gradientColor2 = Colors.white,
    Color gradientColor1 = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [gradientColor1, gradientColor2]),
    boxShadow: showShadow
        ? [BoxShadow(color: food_ShadowColor, blurRadius: 10, spreadRadius: 2)]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

var shadowColorGlobal = Colors.black12;

class AppDecoration {
  BoxDecoration boxDecoration(
      {double radius = 2,
      Color color = Colors.transparent,
      Color bgColor = Colors.white,
      var showShadow = false}) {
    return BoxDecoration(
      color: bgColor,
      boxShadow: showShadow
          ? [
              BoxShadow(
                  color: shadowColorGlobal, blurRadius: 5, spreadRadius: 1)
            ]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  static getInputDecoration(String labelHint) => InputDecoration(
      labelText: labelHint,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      border: const OutlineInputBorder(borderSide: BorderSide(width: 1.4)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(width: 1.6)));

  static getInputDecorationNoLine(String labelHint) => InputDecoration(
      labelText: labelHint,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      border: InputBorder.none,
      focusedBorder: InputBorder.none);

  static getOutLineBoxDecoration([
    Color color = Colors.black,
  ]) =>
      BoxDecoration(
          border: Border.all(
        color: color == null ? Colors.black87 : color,
      ));

  static getBoxGradientDecoration() => BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green.shade50, Colors.white]));

  static getBoxRoundDecoration({Color bColor = Colors.black45}) =>
      BoxDecoration(
          border: Border.all(width: 1, color: bColor),
          borderRadius: new BorderRadius.circular(4),
          color: Colors.white);

  static getRoundRectangleDecoration() =>
      new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4));

  static getRoundRectangleDecorationColor({Color borderColor = Colors.black}) =>
      new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(4),
          side: BorderSide(color: borderColor));

  static getInputDecorationPlain(String labelHint) => InputDecoration(
        labelText: labelHint,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
      );
}
