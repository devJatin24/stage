import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stage/helper/app_utilities/app_images.dart';

double opacityLevel = 1.0;

class MethodUtils {


  static Future<bool> isInternetPresent() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult[0] == ConnectivityResult.mobile) {
        print("Connected to Mobile Network");

        return true;
      } else if (connectivityResult[0] == ConnectivityResult.wifi) {
        print("Connected to WiFi");
        return true;
      } else {
        print("Unable to connect. Please Check Internet Connection");
        return false;
      }
    } on SocketException catch (_) {
      //print('not connected');
      return false;
    }
  }

  static toast(String msg){
   return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  static void showNoInternetCustomDialog(BuildContext context,) {
     showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismiss on tap outside
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.noInternet,
                  height: 120,
                ),
                SizedBox(height: 20),
                Text(
                  'No Internet Connection',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please check your network settings and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {

                      Navigator.of(context).pop(); // Close dialog if connected

                  },
                  child: Text('Back'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}