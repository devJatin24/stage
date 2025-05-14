import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:stage/helper/app_utilities/method_utils.dart';
import 'package:stage/main.dart';
import 'package:stage/model/movie.dart';
import 'package:stage/networkConfig/apiCall.dart';

import '../Repo/movieRepo.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<FavMovies>(_addFavMovie);
    on<SearchEvent>(_search);
    on<ClearSearchEvent>(_clearSearch);
    on<FavAllMovieEvent>(_allMovieFav);
  }

  MovieRepo _repo = MovieRepo(networkRequest: NetworkRequest());
  List<MovieModel> movies = [];


  _onFetchMovies(FetchMovies event, Emitter<MovieState> emit) async {
    try {
      if (await MethodUtils.isInternetPresent()) {
        final response = await _repo.getMovies();
        if (response.isSuccess) {
          // call loaded state
          movies = response.resObject!;
          List<MovieModel> localMovieData = await dbHelper!.getAllMovies();
          if (localMovieData.isNotEmpty) {
            //compare movie list
            movies.forEach((e) {
              localMovieData.forEach((e1) {
                if (e.movieId == e1.movieId) {
                  e.favorite = e1.favorite;
                }
              });
            });
          }
          emit(MovieLoaded(movies: movies));
        } else {
          // call error state
          emit(MovieError(error: response.errorCause));
        }
      } else {
        // get Favourite list from local db
        // MethodUtils.toast("No Internet Favorite movie show");
        movies = await dbHelper!.getAllMovies();
        emit(MovieLoaded(movies: movies));
      }
    } catch (e) {
      emit(MovieError(error: e.toString()));
    }
  }

  _addFavMovie(FavMovies event, Emitter<MovieState> emit) async {
    try {
      bool checkFav = !event.movie.favorite;
      if (checkFav) {
        addMovie(event.movie); // add movie in localDB
      } else {
        // delete movie in localDB
        deleteMovie(event.movie.movieId!);
      }
    } catch (e) {
      debugPrint("Add to fav error $e");
      emit(MovieLoaded(movies: movies));
    }
  }

  deleteMovie(int movieId) async {
    try {
      bool? movieDelSuccessfully = false;
      movieDelSuccessfully = await dbHelper?.deleteMovie(
        movieId,
      ); // add movie in localDB

      if (movieDelSuccessfully!) {
        movies.forEach((e) {
          if (e.movieId == movieId) {
            e.favorite = false;
          }
        });
      }
      MethodUtils.toast("Movie remove to favourite successfully");
      emit(MovieLoaded(movies: movies));
    } catch (e) {
      debugPrint("Delete to fav error $e");
      emit(MovieLoaded(movies: movies));
    }
  }

  addMovie(MovieModel movie) async {
    try {
      movie.favorite = !movie.favorite;
      bool? movieAddSuccessfully = false;
      movieAddSuccessfully = await dbHelper?.insertMovie(movie);

      if (movieAddSuccessfully!) {
        movies.forEach((e) {
          if (e.movieId == movie.movieId) {
            e.favorite = true;
          }
        });
      }
      MethodUtils.toast("Movie added to favourite successfully");
      emit(MovieLoaded(movies: movies));
    } catch (e) {
      debugPrint("Delete to fav error $e");
      emit(MovieLoaded(movies: movies));
    }
  }

  _search(SearchEvent event, Emitter<MovieState> emit) async {
    final query = event.movie.toLowerCase();

    final filteredMovie =
        movies.where((e) {
          return e.title!.toLowerCase().contains(query);
        }).toList();

    emit(MovieLoaded(movies: filteredMovie));
  }

  _clearSearch(ClearSearchEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoaded(movies: movies));
  }

  _allMovieFav(FavAllMovieEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    if (event.addMovie) {
      movies.forEach((e) async {
        e.favorite = true;
        await dbHelper?.insertMovie(e);
      });
    } else {
      await dbHelper?.deleteAllMovies();
      movies.forEach((e) async {
        e.favorite = false;
      });
    }
    emit(MovieLoaded(movies: movies));
  }


  compareWithFilter(String searchWord) async{
     List<MovieModel> localMovieData = await dbHelper!.getAllMovies();
     if (localMovieData.isNotEmpty) {
       //compare movie list
       movies.forEach((e) {
         localMovieData.forEach((e1) {
           if (e.movieId == e1.movieId) {
             e.favorite = e1.favorite;
           }
         });
       });
     }
     if(searchWord.isNotEmpty){
       add(SearchEvent(movie: searchWord));
     }else{
       emit(MovieLoaded(movies: movies));
     }

   }
}
