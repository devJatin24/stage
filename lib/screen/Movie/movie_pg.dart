import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stage/helper/app_utilities/app_theme.dart';
import 'package:stage/helper/app_utilities/method_utils.dart';
import 'package:stage/helper/dxWidget/dx_text.dart';
import 'package:stage/model/movie.dart';

import 'package:cached_network_image/cached_network_image.dart';
import '../../Widgets/loader.dart';
import '../../helper/routeAndBlocManager/app_routes.dart';
import '../../main.dart';
import '../../widgets/error_pg.dart';
import '../../widgets/search.dart';
import '../../widgets/switchButton.dart';
import '../MovieDetail/movieDetails_pg.dart';
import 'Bloc/movie_bloc.dart';

class MovieScreen extends StatelessWidget {
  MovieScreen({super.key});

  late MovieBloc _bloc;
  List<MovieModel> movies = [];
  String _search = "";
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<MovieBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: DxTextWhite("Stage Assignment", mBold: true, mSize: 18),
        actions: [
          SwitchButton(
            onChanged: (s) async {
              if (movies.isNotEmpty) {
                _bloc.add(FavAllMovieEvent(addMovie: s));
              } else {
                MethodUtils.toast("No Movies");
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<MovieBloc, MovieState>(
          builder: (BuildContext context, state) {
            if (state is MovieLoaded) {
              movies = state.movies;
              return body();
            } else if (state is MovieInitial) {
              _bloc.add(FetchMovies());
              return AppLoaderProgress();
            } else if (state is MovieError) {
              return ErrorScreen(text: state.error, onPressed: _refreshData);
            } else if (state is MovieLoading) {
              return Stack(
                children: [body(), Center(child: AppLoaderProgress())],
              );
            }
            return Container();
          },
          listener: (BuildContext context, state) {},
        ),
      ),
    );
  }

  body() {
    return movies.isEmpty
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: DxText("No Movies!", mSize: 18, mBold: true)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _refreshData,
              child: DxTextWhite("Retry"),
            ),
          ],
        )
        : RefreshIndicator(
          child: Column(
            children: [
              SearchWidget(
                hintText: 'Search movies...',
                onChanged: (v) {
                  _search=v;
                  _bloc.add(SearchEvent(movie: v));
                },
                onClear: () {
                  _search = "";
                  _bloc.add(ClearSearchEvent());
                },
              ),

              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: movies.length,
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    // Return your movie grid item widget here
                    return MovieGridItem(
                      movie: movies[index],
                      onFavoriteTap: (movie) {
                        _bloc.add(FavMovies(movie: movie));
                      },
                      onTap: (movie) async {
                        if (await MethodUtils.isInternetPresent()) {
                          Navigator.pushNamed(
                            navigatorKey.currentContext!,
                            AppRoutes.movieDetail,
                            arguments: movie,
                          ).then((v) async{
_bloc.compareWithFilter(_search);


                          });
                        } else {
                          MethodUtils.showNoInternetCustomDialog(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          onRefresh: _refreshData,
        );
  }

  Future<void> _refreshData() async {
    _bloc.add(FetchMovies());
  }
}

class MovieGridItem extends StatelessWidget {
  final MovieModel movie;
  final bool isFavorite;
  final Function(MovieModel)? onFavoriteTap;
  final Function(MovieModel)? onTap;

  MovieGridItem({
    Key? key,
    required this.movie,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
  }) : super(key: key);

  String imageBaseUrl = dotenv.env['ImageBaseUrl']!;

  @override
  Widget build(BuildContext context) {
    final imageurl = "$imageBaseUrl/${movie.backdropPath!}";
    return GestureDetector(
      onTap: () {
        onTap!(movie);
      },
      child: Card(
        elevation: 4,
        shadowColor: materialPrimaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageurl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),

            // Movie Title and Rating
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  ),
                ),
                child: DxText(
                  movie.title!,
                  mBold: true,
                  textColor: Colors.white,
                  maxLines: 2,
                ),
              ),
            ),

            // Favorite Button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  onFavoriteTap!(movie);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    movie.favorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
