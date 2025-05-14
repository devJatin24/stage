import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stage/model/movie.dart';
import 'package:stage/model/movieDetail.dart';

import '../../../helper/app_utilities/method_utils.dart';
import '../../../main.dart';
import '../../../networkConfig/apiCall.dart';
import '../Repo/movieDetailsRepo.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial()) {
    on<FetchMovieDetail>(_fetchMovieDetail);
  }

  MovieDetailRepo _repo = MovieDetailRepo(networkRequest: NetworkRequest());
  late MovieDetailModel movieDetail;
  late MovieModel movie;

  _fetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailsState> emit,
  ) async {
    try {
      emit(MovieDetailsInitial());
      if (await MethodUtils.isInternetPresent()) {
        movie= event.movie;
        final response = await _repo.getMovieDetail(
          movieId: event.movie.movieId!,
        );
        if (response.isSuccess) {
          response.resObject!.fav = event.movie.favorite;
          movieDetail = response.resObject!;
          emit(MovieDetailLoaded(movieDetail: movieDetail));
        } else {
          emit(MovieDetailError(error: response.errorCause));
        }
      } else {
        emit(MovieDetailError(error: "No Internet", noInternet: true));
      }
    } catch (e) {
      emit(MovieDetailError(error: e.toString()));
    }
  }

  addFavMovie(bool checkFav) async {
    if (!checkFav) {
      addMovie(movie); // add movie in localDB
    } else {
      // delete movie in localDB
      deleteMovie(movie.movieId!);
    }
  }

  deleteMovie(int movieId) async {
    try {
       await dbHelper?.deleteMovie(
        movieId,
      ); // add movie in localDB
      movieDetail.fav = false;
       MethodUtils.toast("Movie remove to favourite successfully");
      emit(MovieDetailLoaded(movieDetail: movieDetail));
    } catch (e) {
      emit(MovieDetailLoaded(movieDetail: movieDetail));
    }
  }

  addMovie(MovieModel movie) async {
    try {
      movie.favorite = !movie.favorite;
      movieDetail.fav = true;
      await dbHelper?.insertMovie(movie);
      MethodUtils.toast("Movie added to favourite successfully");
      emit(MovieDetailLoaded(movieDetail: movieDetail));
    } catch (e) {
      emit(MovieDetailLoaded(movieDetail: movieDetail));
    }
  }
}
