import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/models/tmdb/tmdb_movie_basic.dart';
import 'package:movie/ui/widgets/common/components/backdrop_rating.dart';
import 'package:movie/ui/widgets/common/components/details_genres.dart';
import 'package:movie/ui/widgets/common/components/title_duration_and_fav_btn.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key, required this.movie});
  final TMDBMovieBasic movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BackdropAndRating(size: size, movie: movie),
          const SizedBox(
            height: kDefaultPadding / 2,
          ),
          TitleDurationAndFabBtn(movie: movie),
          DetailsGenres(movie: movie),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2,
              horizontal: kDefaultPadding,
            ),
            child: Text(
              "Plot Summary",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              movie.overview!,
              style: const TextStyle(
                color: Color(0xFF737599),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
