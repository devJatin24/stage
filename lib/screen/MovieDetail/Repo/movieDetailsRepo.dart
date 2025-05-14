import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stage/model/movie.dart';
import 'package:stage/model/movieDetail.dart';
import '../../../model/responseCallBack.dart';
import '../../../networkConfig/apiCall.dart';
import '../../../networkConfig/apiEndpoint.dart';

abstract class MovieDetailRepoAbstract {
  Future<ApiResponse<MovieDetailModel>> getMovieDetail({required int movieId});
}

class MovieDetailRepo implements MovieDetailRepoAbstract {
  NetworkRequest networkRequest;

  MovieDetailRepo({required this.networkRequest});

  @override
  Future<ApiResponse<MovieDetailModel>> getMovieDetail({
    required int movieId,
  }) async {
    try {
      MovieDetailModel movies = MovieDetailModel();
      Map<String, dynamic> resp = await networkRequest.networkCallGet(
        ApiUrls.movieDetail(apiKey: dotenv.env["Api_Key"]!, movieId: movieId),
      );
      if (resp['success'] == true) {
        movies = await MovieDetailModel.fromJson(resp);
        return ApiResponse(
          isSuccess: true,
          errorCause: resp["status_message"],
          resObject: movies,
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          errorCause: resp["status_message"],
          resObject: movies,
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
