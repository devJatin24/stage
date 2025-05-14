import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:student_advisor/helper/app_utilities/dx_app_decoration.dart';
// import 'package:student_advisor/helper/app_utilities/size_reziser.dart';

import '../app_utilities/app_theme.dart';
import '../app_utilities/dx_app_decoration.dart';
import '../app_utilities/size_reziser.dart';

class DxTextWhite extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;

  DxTextWhite(this.mTitle, {this.mBold = false, this.mSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      style:
          AppStyles.getTextStyleWhite(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextBlack extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;
  FontWeight fontWeight;
  TextOverflow overflow;
  int? maxLine;

  DxTextBlack(this.mTitle,
      {this.textAlign,
      this.maxLine = 1,
      this.overflow = TextOverflow.ellipsis,
      this.mBold = false,
      this.mSize = 16,
      this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      overflow: overflow,
      maxLines: maxLine,
      style: this.mBold
          ? AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context),
              fontWeight: this.fontWeight)
          : AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context)),
      textAlign: textAlign,
    );
  }
}

class DxRichText extends StatelessWidget {
  String mTitle;
  String mBody;
  bool mBold;
  double mSize;
  double mSizeForBody;
  Color? color;

  DxRichText(
      {required this.mTitle,
      required this.mBody,
      this.mBold = false,
      this.mSize = 20,
      this.mSizeForBody = 18,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 30,
      text: TextSpan(
        text: mTitle,
        style: AppStyles.getTextStyle(
          true,
          getSize(mSize, context),
        ),
        // Added fontWeight for bold text
        children: <TextSpan>[
          TextSpan(
            text: mBody,
            style: AppStyles.getTextStyle(true, getSize(mSizeForBody, context),
                color: color!), // Style for normal text
          ),
        ],
      ),
    );
  }
}

class DxText extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  Color textColor;
  TextAlign? textAlign;
  int maxLines;
  TextOverflow overflow;
  bool lineThrough;

  DxText(this.mTitle,
      {this.mBold = false,
      this.maxLines = 1,
      this.textAlign,
      this.mSize = 16,
      this.lineThrough = false,
      this.overflow = TextOverflow.ellipsis,
      this.textColor = Colors.black,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lineThrough
        ? Text(
            this.mTitle,
            style: AppStyles.getTextStrikeThrough(
              this.mBold,
              getSize(this.mSize, context),
              textColor: textColor,
            ),
            overflow: overflow,
            textAlign: textAlign,
            maxLines: maxLines,
          )
        : Text(
            this.mTitle,
            style: AppStyles.getTextStyle(
                this.mBold, getSize(this.mSize, context),
                color: textColor),
            overflow: overflow,
            textAlign: textAlign,
            maxLines: maxLines,
          );
  }
}

class DxTextRed extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;

  DxTextRed(this.mTitle, {this.mBold = false, this.mSize = 16, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      textAlign: textAlign,
      style:
          AppStyles.getTextStyleRed(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextGreen extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;

  DxTextGreen(this.mTitle,
      {this.mBold = false, this.mSize = 16, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      textAlign: textAlign,
      style:
          AppStyles.getTextStyleGreen(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextPrimary extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign textAlign;
  int maxLines;

  DxTextPrimary(
    this.mTitle, {
    this.mBold = false,
    this.mSize = 16,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      style: AppStyles.getTextStylePrimary(
          this.mBold, getSize(this.mSize, context)),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class DxReachPrimary extends StatelessWidget {
  String mTitle;
  String mSubTitle;
  double mTitleSize;
  double mSubTitleSize;
  TextAlign textAlign;
  bool boldTitle;
  bool boldSubTitle;

  DxReachPrimary(this.mTitle,
      {this.mTitleSize = 17,
      this.mSubTitleSize = 14,
      this.textAlign = TextAlign.left,
      this.mSubTitle = "",
      this.boldTitle = false,
      this.boldSubTitle = false}) {
    this.boldTitle = true;
    this.boldSubTitle = false;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      text: new TextSpan(
        style: AppStyles.getTextStylePrimary(
            false, getSize(this.mTitleSize, context)),
        children: <TextSpan>[
          new TextSpan(
              text: this.mTitle,
              style: new TextStyle(
                fontSize: this.mTitleSize,
                fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
              )),
          new TextSpan(
              text: this.mSubTitle,
              style: new TextStyle(
                  fontSize: this.mSubTitleSize,
                  fontWeight:
                      boldSubTitle ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

class Heading extends StatelessWidget {
  String heading;
  String value;
  double mSize = 18;
  double headingSize = 18;
  Color? valueColor;

  Heading(
      {Key? key,
      required this.heading,
      required this.value,
      this.mSize = 16,
      this.valueColor = Colors.black,
      this.headingSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120,
          child: DxTextBlack(
            heading,
            mBold: true,
            maxLine: 2,
            mSize: headingSize,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: DxText(
                value,
                mSize: mSize,
                maxLines: 4,
                textColor: valueColor!,
              )),
        )
      ],
    );
  }
}
