import 'package:flutter/material.dart';
import 'package:stage/helper/app_utilities/app_images.dart';
import 'package:stage/helper/dxWidget/dx_text.dart';


class ErrorScreen extends StatelessWidget {
  void Function()? onPressed;
  String text;
   ErrorScreen({super.key,this.onPressed,required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(AppImages.error),
      SizedBox(height: 5,),
      DxText(text,mSize: 18,),
      SizedBox(height: 15,),
      ElevatedButton(onPressed: onPressed, child: DxTextWhite("Retry",mBold: true,))
    ],);
  }
}
