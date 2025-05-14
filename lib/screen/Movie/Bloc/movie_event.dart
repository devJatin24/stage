part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent {}

class FetchMovies extends MovieEvent {}

class FavMovies extends MovieEvent {
  MovieModel movie; // we get movie model to add this in local database and when internet is off show the movie
  FavMovies({ required this.movie});
}
class SearchEvent extends MovieEvent {
  String movie;
  SearchEvent({ required this.movie});
}

class ClearSearchEvent extends MovieEvent {}

class FavAllMovieEvent extends MovieEvent {
  bool addMovie;
  FavAllMovieEvent({required this.addMovie});
}
