import 'package:flutter/material.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/components/genre_card.dart';
import 'package:movie/constants.dart';
import 'package:movie/services/api_service.dart';

final _apiService = locator<ApiService>();

class Genres extends StatelessWidget {
  const Genres({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> genres =
        _apiService.allGenresList.map((val) => val['name'] as String).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (
          context,
          index,
        ) =>
            GenreCard(
          genre: genres[index],
          onTapped: ({required String genre}) {
            if (_apiService.genres.contains(genre)) {
              _apiService.genres.remove(genre);
            } else {
              _apiService.genres.add(genre);
              //For adding to search list
            }
          },
        ),
      ),
    );
  }
}
