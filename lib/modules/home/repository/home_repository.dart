import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/modules/home/model/movie_detail.dart';
import 'package:tmdb_app/modules/home/model/movies_list.dart';
import '../../utils/app_keys.dart';
import '../../utils/app_urls.dart';

class HomeRepository {
  /// Fetches the list of popular movies.
  Future<MoviesList?> getMovies({int? page}) async {
    try {
      var headers = {'Authorization': 'Bearer ${AppKeys.token}'};
      var dio = Dio();
      var response = await dio.request(
        '${AppUrls.baseUrl}popular?language=en-US&page=$page',
        options: Options(method: 'GET', headers: headers),
      );

      if (response.statusCode == 200) {
        // Parse the response into the MoviesList model
        return MoviesList.fromJson(response.data);
      }
      // Catch any Dio exceptions (e.g., network errors) and print the error in debug mode
    } on DioException catch (e) {
      if (kDebugMode) print("Dio error: ${e.response?.data}");
    } catch (e) {
      // Catch any other exceptions and print the error in debug mode
      if (kDebugMode) print("Unexpected error: $e");
    }
    return null;
  }

  /// Searches movies based on the provided [searchKey].
  Future<MoviesList?> searchMovies({
    required String searchKey,
    int? page,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer ${AppKeys.token}'};
      var dio = Dio();
      var response = await dio.request(
        'https://api.themoviedb.org/3/search/movie?query=$searchKey&include_adult=false&language=en-US&page=1',
        options: Options(method: 'GET', headers: headers),
      );

      if (response.statusCode == 200) {
        // Parse the search results into the MoviesList model
        return MoviesList.fromJson(response.data);
      }
      // Catch any Dio exceptions (e.g., network errors) and print the error in debug mode
    } on DioException catch (e) {
      if (kDebugMode) print("Dio error: ${e.response?.data}");
    } catch (e) {
      // Catch any other exceptions and print the error in debug mode
      if (kDebugMode) print("Unexpected error: $e");
    }
    return null;
  }

  /// Fetches movie details by its [id].
  Future<MovieDetail?> movieById(int id) async {
    try {
      var headers = {'Authorization': 'Bearer ${AppKeys.token}'};
      var dio = Dio();
      var response = await dio.request(
        'https://api.themoviedb.org/3/movie/$id?language=en-US',
        options: Options(method: 'GET', headers: headers),
      );

      if (response.statusCode == 200) {
        // Parse the response into the MovieDetail model
        return MovieDetail.fromJson(response.data);
      }
      // Catch any Dio exceptions (e.g., network errors) and print the error in debug mode
    } on DioException catch (e) {
      if (kDebugMode) print("Dio error: ${e.response?.data}");
    } catch (e) {
      // Catch any other exceptions and print the error in debug mode
      if (kDebugMode) print("Unexpected error: $e");
    }
    return null;
  }
}
