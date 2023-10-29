import 'package:flutter/material.dart';
import 'package:moviesapp/shared/styles/colors.dart';

class MoviePoster extends StatelessWidget {
  bool active;

  MoviePoster(this.active);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            // width: 150,
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/RedCat_8727.jpg/1280px-RedCat_8727.jpg",
              height: double.infinity,
              width: 150,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: -8,
            left: -12,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.bookmark,
                  color: active
                      ? MyColors.tapBarIconColor
                      : MyColors.BookmarkIconColor,
                  size: 60,
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
