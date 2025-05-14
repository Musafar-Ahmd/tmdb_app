import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/app_keys.dart';
import '../../../utils/app_urls.dart';
import '../model/reviews.dart';

class ReviewRepository {
  Future<Reviews?> reviews(int id) async {
    try {
      // Set up headers with authorization token
      var headers = {'Authorization': 'Bearer ${AppKeys.token}'};
      var dio = Dio();
      var response = await dio.request(
        '${AppUrls.baseUrl}$id/reviews?language=en-US&page=1',
        options: Options(method: 'GET', headers: headers),
      );

      // If the status code of the response is 200 (OK), parse and return the reviews
      if (response.statusCode == 200) {
        return Reviews.fromJson(response.data);
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
