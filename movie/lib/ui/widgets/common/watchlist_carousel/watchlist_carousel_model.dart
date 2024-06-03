import 'package:flutter/material.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/models/tmdb/tmdb_movie_basic.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/services/firebase_auth_service.dart';
import 'package:movie/services/firestore_service.dart';
import 'package:movie/services/movie_carousel_service.dart';
import 'package:stacked/stacked.dart';

class WatchlistCarouselModel extends StreamViewModel {
  int currentPage = 1;
  late PageController _pageController;
  final _movieCarouselService = locator<MovieCarouselService>();
  final _firestoreService = locator<FirestoreService>();
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _apiService = locator<ApiService>();
  ReactiveList get watchList => _movieCarouselService.watchList;
  PageController get pageController => _pageController;

  WatchlistCarouselModel() {
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: currentPage,
    );
  }
  void setCurrentPage(int value) {
    currentPage = value;
    rebuildUi();
  }

  @override
  void onData(data) async {
    super.onData(data);

    var res = await watchListMovies(data);

    _movieCarouselService.watchList.assignAll(res);
    rebuildUi();
  }

  Future<List<TMDBMovieBasic>> watchListMovies(List<int> ids) async {
    var res = await _apiService.findAllMovies(ids);
    return res;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  // TODO: implement stream
  Stream get stream => _firestoreService.listenToWatchlistChanges(
      userEmail: _firebaseAuthService.user!.email);

  runStartupLogic() async {
    var favouriteMovieIds = await _firestoreService.userFavourites(
        userEmail: _firebaseAuthService.user!.email);
    var res = await _apiService.findAllMovies(favouriteMovieIds);
    watchList.assignAll(res);
  }
}
