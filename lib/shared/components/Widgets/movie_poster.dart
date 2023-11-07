import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/details_model.dart';
import 'package:moviesapp/screens/movie_details.dart';
import 'package:moviesapp/models/MoviesResponse.dart';
import 'package:moviesapp/shared/network/local/firebase_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';

import '../../../models/MoviesResponse.dart';

class MoviePoster extends StatefulWidget {
  // bool active;
  final String posterLink;
  final Results? singleMovieResult;
  // final MovieDetailsResponse? movieDetailsResponse;
  // final GenresModel? genresModel;

  const MoviePoster(this.posterLink, {super.key, this.singleMovieResult});

  Results movie;

  MoviePoster(this.movie);


  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {

  bool active = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.singleMovieResult == null) return;
        MovieDetailsModel mm = MovieDetailsModel(
          movieTitle: widget.singleMovieResult!.title ?? "",
          movieId: widget.singleMovieResult!.id ?? -1,
          poster: widget.singleMovieResult!.posterPath ?? MovieDetails.def,
          time: widget.singleMovieResult!.releaseDate ?? "",
          backdropPath:
              widget.singleMovieResult!.backdropPath ?? MovieDetails.def,
          overview: widget.singleMovieResult!.overview ?? "",
          voteAverage: widget.singleMovieResult!.voteAverage ?? 0.0,
        );

        Navigator.pushNamed(
          context,
          MovieDetails.routeName,
          arguments: mm,
        );
        // setState(() {
        //
        // });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/w500${widget.singleMovieResult != null ? widget.singleMovieResult!.posterPath : widget.posterLink}",
                height: double.infinity,
                width: 150,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: -8,
              left: -13,
              child: InkWell(
                onTap: () {
                  active = !active;
                  setState(() {});
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: active
                          ? MyColors.tapBarIconColor
                          : MyColors.BookmarkIconColor,
                      size: 60,
                    ),
                    Icon(
                      active ? Icons.check : Icons.add,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

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
