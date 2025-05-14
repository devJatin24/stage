

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls{
  static String baseUrl(String endPoint) =>
      "${dotenv.env['Base_Url']}/$endPoint";

  static String getPopularMovies({required String apiKey,}) => baseUrl("movie/popular?api_key=$apiKey");
  static String movieDetail({required String apiKey,required int movieId}) => baseUrl("movie/$movieId?api_key=$apiKey");
}