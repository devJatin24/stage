import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stage/model/movie.dart';
import '../../../model/responseCallBack.dart';
import '../../../networkConfig/apiCall.dart';
import '../../../networkConfig/apiEndpoint.dart';

abstract class MovieRepoAbstract {
  Future<ApiResponse<List<MovieModel>>> getMovies();
}

class MovieRepo implements MovieRepoAbstract {
  NetworkRequest networkRequest;

  MovieRepo({required this.networkRequest});

  @override
  Future<ApiResponse<List<MovieModel>>> getMovies() async {
    try {
      List<MovieModel> movies = [];
      Map<String, dynamic> resp = await networkRequest.networkCallGet(
        ApiUrls.getPopularMovies(apiKey: dotenv.env["Api_Key"]!),
      );
      if (resp['success'] == true) {
        final data =
            resp['results']
                as List<
                  dynamic
                >; // get dara from result key then convert in movies model list
        if (data != null) {
          movies = await List.generate(
            data.length,
            (index) => MovieModel.fromJson(data[index]),
          );
        }
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


