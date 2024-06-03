import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/ui/views/home/components/genres.dart';
import 'package:movie/ui/widgets/common/movie_carousel/movie_carousel.dart';
import 'package:movie/ui/widgets/common/watchlist_carousel/watchlist_carousel.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Genres(),
          SizedBox(
            height: kDefaultPadding,
          ),
          MovieCarousel(
            key: Key('moviecarousel'),
          ),
          Text(
            'Your favourite movies :',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          WatchlistCarousel(),
        ],
      ),
    );
  }
}
