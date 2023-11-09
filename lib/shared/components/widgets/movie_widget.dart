import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/MoviesResponse.dart';
import 'package:moviesapp/shared/network/local/firebase_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';

class MovieWidget extends StatefulWidget {
  Results movieModel;

  MovieWidget(this.movieModel, {super.key});

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  bool isMovieInWatchList = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Results>>(
      stream:
          FirebaseManager.getMoviesInWatchListById(widget.movieModel.id ?? 0),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(right: 10),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                              height: 90,
                              width: 130,
                              fit: BoxFit.cover,
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w300/${widget.movieModel.posterPath!}',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error)),
                        ),
                      ),
                      Positioned(
                        top: -8,
                        left: -13,
                        child: InkWell(
                          onTap: () {
                            if (isMovieInWatchList == true) {
                              FirebaseManager.removeFromWatchList(
                                  widget.movieModel.id ?? 0);
                            } else {
                              FirebaseManager.addToWatchList(widget.movieModel);
                            }
                            isMovieInWatchList = !isMovieInWatchList;
                            setState(() {});
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.bookmark,
                                color: isMovieInWatchList == true
                                    ? MyColors.tapBarIconColor
                                    : MyColors.grayColor,
                                size: 60,
                              ),
                              Icon(
                                isMovieInWatchList == true
                                    ? Icons.check
                                    : Icons.add,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.movieModel.title ?? '',
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateTime.parse(widget.movieModel.releaseDate ?? '')
                              .year
                              .toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        }
      },
    );
  }
}
