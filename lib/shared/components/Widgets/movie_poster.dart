import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/details_model.dart';
import 'package:moviesapp/screens/movie_details.dart';
import 'package:moviesapp/shared/styles/colors.dart';

import '../../../models/MoviesResponse.dart';

class MoviePoster extends StatefulWidget {
  bool active;
  String posterLink;

  // Results movieModel;
  MoviePoster(this.active, this.posterLink);

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context, MovieDetails.routeName,
          // arguments: MovieDetailsModel(movieTitle:widget.movieModel.title??"" , movieId:widget.movieModel.id??1991 ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CachedNetworkImage(
                imageUrl: "${widget.posterLink}",
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
                  widget.active = !widget.active;
                  setState(() {});
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: widget.active
                          ? MyColors.tapBarIconColor
                          : MyColors.BookmarkIconColor,
                      size: 60,
                    ),
                    Icon(
                      widget.active ? Icons.check : Icons.add,
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
