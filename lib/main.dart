import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stage/screen/Auth/splash/splash_pg.dart';
import 'package:stage/screen/Movie/movie_pg.dart';
import 'package:stage/screen/MovieDetail/movieDetails_pg.dart';

import 'DB/movieDB.dart';
import 'helper/app_utilities/app_theme.dart';
import 'helper/app_utilities/size_reziser.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'helper/routeAndBlocManager/app_routes.dart';
import 'helper/routeAndBlocManager/blocProvider.dart';

DatabaseHelper? dbHelper;
Database? database;

void main() async{
  await dotenv.load(fileName: ".env");
  dbHelper = DatabaseHelper.instance;
  // database = await database;
  runApp(const MyApp());
}


final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: materialPrimaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness:
        Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: BlocManager.blocProviders,
      child: MaterialApp(
        navigatorKey: navigatorKey,
          title: '',
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          debugShowCheckedModeBanner:false,
          theme: defaultAppThemeData,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

