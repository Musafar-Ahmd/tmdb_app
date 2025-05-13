import 'package:flutter/cupertino.dart';
import 'package:tmdb_app/modules/reviews/repository/review_repository.dart';

import '../model/reviews.dart';

class ReviewViewModel extends ChangeNotifier {
  final ReviewRepository _repository = ReviewRepository();

  Reviews? reviews;
  List<Results> moviesList = [];
  int currentPage = 1;

  Future getMovies(id) async {
    _repository.reviews(id).then((value) {
      reviews = value;
      notifyListeners();
    });
  }
}
