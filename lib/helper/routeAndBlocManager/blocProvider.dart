import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:stage/screen/Movie/Bloc/movie_bloc.dart';
import 'package:stage/screen/MovieDetail/Bloc/movie_details_bloc.dart';
import '../../screen/Favorite/favorite_movie_bloc.dart';

class BlocManager {
  static List<SingleChildWidget> get blocProviders => [
    BlocProvider(create: (context) => MovieBloc()),
    BlocProvider(create: (context) => MovieDetailsBloc()),
    BlocProvider(create: (context) => FavoriteMovieBloc()),
  ];
}
