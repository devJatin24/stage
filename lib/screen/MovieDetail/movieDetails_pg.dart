import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stage/model/movie.dart';
import 'package:stage/model/movieDetail.dart';

import '../../Widgets/loader.dart';
import '../../helper/dxWidget/dx_text.dart';
import '../../widgets/error_pg.dart';
import 'Bloc/movie_details_bloc.dart';

class MovieDetailsScreen extends StatelessWidget {
  MovieModel movie;

  MovieDetailsScreen({super.key, required this.movie});

  late MovieDetailsBloc _bloc;
  MovieDetailModel? movieDetail;
  String imageBaseUrl = dotenv.env['ImageBaseUrl']!;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<MovieDetailsBloc>(context);
    _bloc.add(FetchMovieDetail(movie: movie));
    return Scaffold(
      appBar: AppBar(
        title: DxTextWhite("Movie Detail", mBold: true, mSize: 18),
      ),
      body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        builder: (BuildContext context, state) {
          if (state is MovieDetailLoaded) {
            movieDetail = state.movieDetail;
            return body();
          } else if (state is MovieDetailsInitial) {
            return AppLoaderProgress();
          } else if (state is MovieDetailError) {
            return ErrorScreen(text: state.error,onPressed: (){
              _bloc.add(FetchMovieDetail(movie: movie));
            },);
          }
          return Container();
        },
        listener: (BuildContext context, state) {},
      ),
    );
  }

  body() {
    if (movieDetail == null) {
      return Center(child: DxText("No Data Found", mSize: 18, mBold: true));
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: "$imageBaseUrl/${movieDetail!.backdropPath!}",
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    _bloc.addFavMovie(movieDetail!.fav);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      movieDetail!.fav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "$imageBaseUrl/${movieDetail!.backdropPath!}",
                    height: 200,
                    width: 150,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(child: movieContent()),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                DxText("Movie Language"),
                SizedBox(width: 10),
                movieLanguage(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: DxText(movieDetail!.overview!, maxLines: 50),
          ),
        ],
      ),
    );
  }

  movieContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DxText(movieDetail!.title!, mBold: true, maxLines: 2, mSize: 18),
        DxText("Voting: ${movieDetail!.voteCount}"),
        DxText("Release Date: ${movieDetail!.releaseDate}"),
      ],
    );
  }

  movieLanguage() {
    return movieDetail!.spokenLanguages!.isEmpty
        ? SizedBox.shrink()
        : Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children:
              movieDetail!.spokenLanguages!
                  .map(
                    (SpokenLanguages) => Chip(
                      label: DxTextWhite(SpokenLanguages.name!),
                      backgroundColor: Colors.black45,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  )
                  .toList(),
        );
  }
}
