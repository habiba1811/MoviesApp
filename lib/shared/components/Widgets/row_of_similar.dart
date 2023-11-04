import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapp/models/MoviesResponse.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';

import 'movie_poster.dart';

class RowOfSimilar extends StatelessWidget {
  String
      title; //type 1 New Releases or upcoming        type 2 is recommended  type 3 is Similar
  Results movieModel;

  RowOfSimilar(this.title, this.movieModel);

  String def =
      "https://thumbs.dreamstime.com/z/no-photo-blank-image-icon-loading-images-missing-image-mark-image-not-available-image-coming-soon-sign-no-photo-blank-215973362.jpg?w=2048";

  @override
  Widget build(BuildContext context) {
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
            future: ApiManager.getSimilar(movieModel.id ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text("An Error has occured",
                    style: TextStyle(color: Colors.white));
              }
              if (snapshot.data?.success == false) {
                return Text("Failed request check sent parameters",
                    style: TextStyle(color: Colors.white));
              }
              var SimilarMovies = snapshot.data?.results ?? [];

              return Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: SimilarMovies.length,
                itemBuilder: (context, index) {
                  return MoviePoster(
                      false,
                      SimilarMovies[index].posterPath == null
                          ? def
                          : "https://image.tmdb.org/t/p/w500${SimilarMovies[index].posterPath}",
                      movieModel);
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
//ApiManager.getRecommended()
