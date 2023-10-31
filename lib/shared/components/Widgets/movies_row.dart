import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';

import 'movie_poster.dart';

class MoviesRow extends StatelessWidget {
  String title;
  int type; //type 1 New Releases or upcoming        type 2 is recommended
  MoviesRow(this.title, this.type);

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
            future: type == 1
                ? ApiManager.getUpcoming()
                : ApiManager.getRecommended(),
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
              var UpcomingMovies = snapshot.data?.results ?? [];
              return Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: UpcomingMovies.length,
                itemBuilder: (context, index) {
                  UpcomingMovies[index].posterPath = UpcomingMovies[index]
                              .posterPath ==
                          null
                      ? def
                      : "https://image.tmdb.org/t/p/w500${UpcomingMovies[index].posterPath}";
                  return MoviePoster(UpcomingMovies[index]);
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
