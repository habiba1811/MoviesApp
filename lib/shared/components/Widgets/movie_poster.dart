import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/shared/styles/colors.dart';

class MoviePoster extends StatefulWidget {
  bool active;
  String posterLink;

  MoviePoster(this.active, this.posterLink);

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
