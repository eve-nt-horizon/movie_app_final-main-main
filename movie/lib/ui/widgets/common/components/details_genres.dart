import 'package:flutter/material.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/components/genre_card.dart';
import 'package:movie/constants.dart';
import 'package:movie/models/tmdb/tmdb_movie_basic.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/services/movie_carousel_service.dart';
import 'package:stacked_services/stacked_services.dart';

final _apiService = locator<ApiService>();
final _navigationService = locator<NavigationService>();
final _movieCarouselService = locator<MovieCarouselService>();

class DetailsGenres extends StatelessWidget {
  const DetailsGenres({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final TMDBMovieBasic movie;

  @override
  Widget build(BuildContext context) {
    var genres = [];
    if (movie.genreIds != null) {
      genres = _apiService.allGenresList
          .where((val) => movie.genreIds!.contains(val['id']))
          .map((val) => val['name'])
          .toList();
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: genres.length,
          itemBuilder: (context, index) => GenreCard(
            genre: '${genres[index]}',
            onTapped: ({required String genre}) async {
              var genreVal = _apiService.allGenresList
                  .firstWhere((val) => val['name'] == genre);
              var id = [genreVal['id']];
              var res = await _apiService.searchWithGenres(id);
              _movieCarouselService.movieList.assignAll(res);
              _navigationService.back();
            },
          ),
        ),
      ),
    );
  }
}
