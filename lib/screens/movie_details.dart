import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapp/models/details_model.dart';
import 'package:moviesapp/shared/components/Widgets/row_of_similar.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';

class MovieDetails extends StatefulWidget {
  static String routeName = 'movieDetails';
  String def =
      "https://thumbs.dreamstime.com/z/no-photo-blank-image-icon-loading-images-missing-image-mark-image-not-available-image-coming-soon-sign-no-photo-blank-215973362.jpg?w=2048";

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args =
          ModalRoute.of(context)?.settings.arguments as MovieDetailsModel;
      //print (args.runtime);
      print(args.overview);
    });
  }

  Widget build(BuildContext context) {
    var args = ModalRoute
        .of(context)
        ?.settings
        .arguments as MovieDetailsModel;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          args.movieTitle,
          style: GoogleFonts.inter(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${args.poster}"),
                            fit: BoxFit.fill)),
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  Text(
                    snapshot.data!.title!,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                  Row(
                    children: [
                      Text(
                        DateTime.parse(args.time).year.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text("${args.runtime}"),
                    ],
                  )
                ],
              );
            },
          ),
          Expanded(
              child: Container(
            height: 180,
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

