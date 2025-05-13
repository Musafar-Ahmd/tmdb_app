import 'package:flutter/cupertino.dart';
import 'package:tmdb_app/modules/home/model/movie_detail.dart';
import 'package:tmdb_app/modules/home/model/movies_list.dart';
import 'package:tmdb_app/modules/home/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepository();

  MoviesList? movies;
  MoviesList? searchList;
  List<Results> moviesList = [];
  MovieDetail? detail;
  bool isLoading = false;
  int page = 1;
  bool getAllMovies = false;

  Future getMovies() async {
    _homeRepository.getMovies(page: page).then((value) {
      movies = value;
      moviesList = value?.results ?? [];
      notifyListeners();
    });
  }

  Future loadAllMovies() async {
    getAllMovies = true;
    notifyListeners();
    page++;
    await _homeRepository.getMovies(page: page).then((value) {
      if (value?.results != null) {
        moviesList.addAll(value?.results ?? []);
      }
    });
    getAllMovies = false;
    notifyListeners();
  }

  Future searchMovies(searchKey) async {
    isLoading = true;
    _homeRepository.searchMovies(searchKey: searchKey).then((value) {
      searchList = value;
      moviesList = value?.results ?? [];
      isLoading = false;
      notifyListeners();
    });
  }

  Future movieDetail(id) async {
    isLoading = true;
    _homeRepository.movieById(id).then((value) {
      detail = value;
      isLoading = false;
      notifyListeners();
    });
  }
}
