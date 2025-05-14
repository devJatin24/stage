import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_movie_event.dart';
part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  FavoriteMovieBloc() : super(FavoriteMovieInitial()) {
    on<FavoriteMovieEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
