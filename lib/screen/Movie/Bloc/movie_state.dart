part of 'movie_bloc.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieError extends MovieState {
  String error;
  bool noInternet = false;
  MovieError({ required this.error,this.noInternet=false});
}


final class MovieLoaded extends MovieState {
  List<MovieModel> movies = [];
  MovieLoaded({required this.movies,});
}
