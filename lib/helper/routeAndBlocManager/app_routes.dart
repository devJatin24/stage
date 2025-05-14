import 'package:flutter/material.dart';
import 'package:stage/model/movie.dart';
import 'package:stage/screen/Auth/splash/splash_pg.dart';
import 'package:stage/screen/Movie/movie_pg.dart';
import 'package:stage/screen/MovieDetail/movieDetails_pg.dart';

class AppRoutes {
  static const String splash = '/';
  static const String movie = '/movie';
  static const String movieDetail = '/movieDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case movie:
        final args = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => MovieScreen());

      case movieDetail:
        final args = settings.arguments as MovieModel;
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: args,));

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}