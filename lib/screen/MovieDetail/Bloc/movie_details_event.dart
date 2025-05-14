part of 'movie_details_bloc.dart';

@immutable
sealed class MovieDetailsEvent {}

class FetchMovieDetail extends MovieDetailsEvent {
  MovieModel movie;
  FetchMovieDetail({required this.movie,});
}

