import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/app/app.router.dart';
import 'package:movie/models/tmdb/tmdb_movie_basic.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/services/firebase_auth_service.dart';
import 'package:movie/services/movie_carousel_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends StreamViewModel {
  final _apiService = locator<ApiService>();
  final _movieCarouselService = locator<MovieCarouselService>();
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _navigationService = locator<NavigationService>();
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  User? get user => _firebaseAuthService.user;

  @override
  Stream<User?> get stream => _firebaseAuthService.onAuthStateChanged;

  Future search() async {
    if (_searchController.text.isNotEmpty) {
      await searchWithSearchQuery();
    } else {
      await searchWithGenres();
    }
  }

  Future searchWithGenres() async {
    final genres = _apiService.genres;
    if (genres.isEmpty) return;
    List<int> queries = _apiService.allGenresList
        .where((val) => genres.contains(val['name']))
        .map((val) => val['id'] as int)
        .toList();
    List<TMDBMovieBasic> res = await _apiService.searchWithGenres(queries);
    _movieCarouselService.movieList.assignAll(res);
  }

  Future searchWithSearchQuery() async {
    if (_searchController.text.isEmpty) return;
    List<TMDBMovieBasic> res = await _apiService.search(_searchController.text);
    _movieCarouselService.movieList.assignAll(res);
  }

  void replaceWithSignInView() {
    _navigationService.replaceWithSignInView();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void resetPage() {}
}
