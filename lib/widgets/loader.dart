import 'package:flutter/material.dart';

import '../helper/app_utilities/size_reziser.dart';

class AppLoaderProgress extends StatelessWidget {
  const AppLoaderProgress();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color: Colors.transparent,
      child: Center(
        child:  Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child:  Padding(
                padding: const EdgeInsets.all(4.0),
                // child: Image.asset(AppImages.loader)
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                )
            )

        ),
      ),
    );
  }
}
