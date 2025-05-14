part of 'movie_details_bloc.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailLoaded extends MovieDetailsState {
  MovieDetailModel movieDetail;
  MovieDetailLoaded({required this.movieDetail});
}

final class MovieDetailError extends MovieDetailsState {
  String error;
  bool noInternet = false;
  MovieDetailError({required this.error,this.noInternet = false});
}
