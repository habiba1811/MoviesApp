import 'package:flutter/material.dart';
import 'package:moviesapp/models/MoviesResponse.dart';
import 'package:moviesapp/shared/components/Widgets/movies_row.dart';
import 'package:moviesapp/shared/components/Widgets/row_of_similar.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';

class MovieDetails extends StatelessWidget {
  static String routeName = 'movieDetails';
  Results movieModel;

  MovieDetails(this.movieModel);


  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FutureBuilder(
        //   future: ApiManager.(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return Text("An Error has occured",
        //           style: TextStyle(color: Colors.white));
        //     }
        //     if (snapshot.data?.success == false) {
        //       return Text("Failed request check sent parameters",
        //           style: TextStyle(color: Colors.white));
        //     }
        //     var UpcomingMovies = snapshot.data?.results ?? [];
        //     return MyCarousel(UpcomingMovies);
        //   },
        // ),
        Expanded(child: RowOfSimilar("Recommended",)),
      ],
    );
  }
}