import 'package:flutter/material.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/constants.dart';

import 'package:movie/models/tmdb/tmdb_movie_basic.dart';
import 'package:movie/services/firebase_auth_service.dart';
import 'package:movie/services/firestore_service.dart';

final _firestoreService = locator<FirestoreService>();
final _fireauthService = locator<FirebaseAuthService>();

class TitleDurationAndFabBtn extends StatelessWidget {
  const TitleDurationAndFabBtn({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final TMDBMovieBasic movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: <Widget>[
                    Text(
                      '${movie.releaseDate}',
                      style: const TextStyle(color: kTextLightColor),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    const Text(
                      "PG-13",
                      style: TextStyle(color: kTextLightColor),
                    ),
                    SizedBox(width: kDefaultPadding),
                    const Text(
                      "2h 32min",
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 64,
            width: 64,
            child: TextButton(
              onPressed: () async {},
              style: TextButton.styleFrom(
                backgroundColor: kSecondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: StreamBuilder(
                  stream: _firestoreService.listenToWatchlistChanges(
                      userEmail: _fireauthService.user!.email),
                  builder: (context, snapshot) {
                    IconData icon;
                    if (snapshot.data != null &&
                        snapshot.data!.contains(movie.id)) {
                      icon = Icons.remove;
                    } else {
                      icon = Icons.add;
                    }
                    return IconButton(
                        onPressed: () async {
                          if (snapshot.data!.contains(movie.id)) {
                            await _firestoreService.removeMovie(
                                userEmail: _fireauthService.user!.email,
                                movieId: movie.id);
                          } else {
                            await _firestoreService.addMovie(
                                userEmail: _fireauthService.user!.email,
                                movieId: movie.id);
                          }
                        },
                        icon: Icon(
                          icon,
                          size: 28,
                          color: Colors.white,
                        ));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
