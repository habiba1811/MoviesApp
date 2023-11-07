import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesapp/models/MoviesResponse.dart';

class FirebaseManager {
  static CollectionReference<Results> getWatchListCollection() {
    return FirebaseFirestore.instance
        .collection("Watchlist")
        .withConverter<Results>(fromFirestore: (snapshot, _) {
      return Results.fromJson(snapshot.data()!);
    }, toFirestore: (movie, _) {
      return movie.toJson();
    });
  }

  static Future<void> addToWatchList(Results movie) {
    var collection = getWatchListCollection();
    var docRef = collection.doc();
    return docRef.set(movie);
  }

  static Stream<QuerySnapshot<Results>> getWatchList() {
    return getWatchListCollection().snapshots();
  }

  static removeFromWatchList(num movieId) async {
    var snapshot =
        await getWatchListCollection().where("id", isEqualTo: movieId).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Stream<QuerySnapshot<Results>> getMoviesInWatchListById(num movieId) {
    return getWatchListCollection().where("id", isEqualTo: movieId).snapshots();
  }
}
