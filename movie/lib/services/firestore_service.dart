import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final StreamController<List<int>> _watchlistController =
      StreamController.broadcast();

  Stream<List<int>> listenToWatchlistChanges({required userEmail}) {
    _usersCollectionReference
        .doc(userEmail)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      var firestoreData = documentSnapshot.data() as Map<String, dynamic>;
      if (firestoreData.isNotEmpty) {
        var buffer = (firestoreData['movieId'] as List)
            .map((val) => val as int)
            .toList();
        _watchlistController.add(buffer);
      }
    });

    return _watchlistController.stream;
  }

  Future addMovie({required userEmail, required movieId}) async {
    try {
      var doc = await _usersCollectionReference.doc(userEmail).get();
      if (doc.exists) {
        await _usersCollectionReference.doc(userEmail).update({
          'movieId': FieldValue.arrayUnion([movieId])
        });
      } else {
        await _usersCollectionReference.doc(userEmail).set({
          'movieId': [movieId].toList()
        });
      }
      print('Saved');
    } catch (e) {
      print(e);
    }
  }

  Future removeMovie({required userEmail, required movieId}) async {
    try {
      await _usersCollectionReference.doc(userEmail).update({
        'movieId': FieldValue.arrayRemove([movieId])
      });

      print('Saved');
    } catch (e) {
      print(e);
    }
  }

  Future userFavourites({required userEmail}) async {
    final docRef = _usersCollectionReference.doc(userEmail);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['movieId'];
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
