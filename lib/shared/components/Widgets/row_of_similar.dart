import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapp/models/details_model.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';

import 'movie_poster.dart';

class RowOfSimilar extends StatelessWidget {
  String title;

  RowOfSimilar(this.title);

  String def =
      "https://thumbs.dreamstime.com/z/no-photo-blank-image-icon-loading-images-missing-image-mark-image-not-available-image-coming-soon-sign-no-photo-blank-215973362.jpg?w=2048";

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MovieDetailsModel;
    return Container(
      decoration: BoxDecoration(color: MyColors.moviesRowBackColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
          ),
          FutureBuilder(
            future: ApiManager.getSimilar(args.movieId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Text("An Error has occured",
                    style: TextStyle(color: Colors.white));
              }
              if (snapshot.data?.success == false) {
                return const Text("Failed request check sent parameters",
                    style: TextStyle(color: Colors.white));
              }
              var similarMovies = snapshot.data?.results ?? [];

              return Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: similarMovies.length,
                itemBuilder: (context, index) {
                  return MoviePoster(
                    similarMovies[index].posterPath == null
                        ? def
                        : "https://image.tmdb.org/t/p/w500${similarMovies[index].posterPath}",
                    singleMovieResult: similarMovies[index],
                  );
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
