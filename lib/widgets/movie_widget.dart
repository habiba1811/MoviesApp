import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/MoviesResponse.dart';

class MovieWidget extends StatelessWidget {
  Results movieModel;

  MovieWidget(this.movieModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          Card(
            margin: EdgeInsets.only(right: 10),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  height: 90,
                  width: 130,
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w300/${movieModel.posterPath!}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error)),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movieModel.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(
                  height: 5,
                ),
                Text(
                  DateTime.parse(movieModel.releaseDate ?? '').year.toString(),
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
