import 'package:flutter/material.dart';
import 'package:movie/models/tmdb/tmdb_movie_basic.dart';
import 'package:movie/ui/widgets/common/components/details_body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.movie});
  final TMDBMovieBasic movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailsBody(movie: movie),
    );
  }
}
