import 'package:flutter/material.dart';
import 'package:moviesapp/models/details_model.dart';
import 'package:moviesapp/shared/components/Widgets/row_of_similar.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';

class MovieDetails extends StatefulWidget {
  static String routeName = 'movieDetails';

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args =
      ModalRoute
          .of(context)
          ?.settings
          .arguments as MovieDetailsModel;
    });
  }

  Widget build(BuildContext context) {
    var args = ModalRoute
        .of(context)
        ?.settings
        .arguments as MovieDetailsModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.movieTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: ApiManager.getMovieDetails(args.movieId),
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
              // if (snapshot.hasData) {
              //
              //   // return Text("Failed request check sent parameters",
              //   //     style: TextStyle(color: Colors.white));
              // }
              // var upcomingMovies = snapshot.data!.results ?? [];
              // return MyCarousel(UpcomingMovies);
              return (Text(snapshot.data!.title!));
            },
          ),
          Expanded(
              child: RowOfSimilar(
                "More Like This",
              )),
          Expanded(
              child: RowOfSimilar(
                "More Like This",
              )),
        ],
      ),
    );
  }
}
