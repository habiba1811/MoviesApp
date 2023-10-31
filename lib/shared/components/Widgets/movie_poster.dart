import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/MoviesResponse.dart';
import 'package:moviesapp/shared/network/local/firebase_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';

class MoviePoster extends StatefulWidget {
  Results movie;

  MoviePoster(this.movie);

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  bool isMovieInWatchList = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Results>>(
        stream: FirebaseManager.getMoviesInWatchListById(widget.movie.id ?? 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var movies =
                  snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
              isMovieInWatchList = movies.length > 0;
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: CachedNetworkImage(
                        imageUrl: "${widget.movie.posterPath}",
                        height: double.infinity,
                        width: 130,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: -8,
                      left: -13,
                      child: InkWell(
                        onTap: () {
                          if (isMovieInWatchList == true) {
                            FirebaseManager.removeFromWatchList(
                                widget.movie.id ?? 0);
                          } else {
                            FirebaseManager.addToWatchList(widget.movie);
                          }
                          isMovieInWatchList = !isMovieInWatchList;
                          setState(() {});
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: isMovieInWatchList
                                  ? MyColors.tapBarIconColor
                                  : MyColors.BookmarkIconColor,
                              size: 60,
                            ),
                            Icon(
                              isMovieInWatchList ? Icons.check : Icons.add,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
        });
  }
}
