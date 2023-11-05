import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/details_model.dart';
import 'package:moviesapp/screens/movie_details.dart';
import 'package:moviesapp/shared/styles/colors.dart';

import '../../../models/MoviesResponse.dart';

class MoviePoster extends StatefulWidget {
  // bool active;
  final String posterLink;
  final Results? singleMovieResult;
  // final MovieDetailsResponse? movieDetailsResponse;

  const MoviePoster(this.posterLink, {super.key, this.singleMovieResult});

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
          poster: widget.singleMovieResult!.posterPath ?? "",
          time: widget.singleMovieResult!.releaseDate ?? "",
        );
        print(mm.movieId);
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
  }
}
