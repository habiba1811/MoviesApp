import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapp/models/MoviesResponse.dart';
import 'package:moviesapp/shared/components/Widgets/movie_poster.dart';

class MyCarousel extends StatefulWidget {
  @override
  List<Results> results;

  MyCarousel(this.results);

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  //String movieName="Not available";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 180.0, autoPlay: true, viewportFraction: 1),
            items: widget.results.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: CachedNetworkImage(
                        height: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: movie.backdropPath == null
                            ? "https://thumbs.dreamstime.com/z/no-photo-blank-image-icon-loading-images-missing-image-mark-image-not-available-image-coming-soon-sign-no-photo-blank-215973362.jpg?w=2048"
                            : "https://image.tmdb.org/t/p/w500${movie.backdropPath}"),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
              top: 100,
              left: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 150.0, autoPlay: true, viewportFraction: 1),
                  items: widget.results.map((movie) {
                    return Builder(
                      builder: (BuildContext context) {
                        return MoviePoster(
                            false,
                            movie.posterPath == null
                                ? "https://thumbs.dreamstime.com/z/no-photo-blank-image-icon-loading-images-missing-image-mark-image-not-available-image-coming-soon-sign-no-photo-blank-215973362.jpg?w=2048"
                                : "https://image.tmdb.org/t/p/w500${movie.posterPath}");
                      },
                    );
                  }).toList(),
                ),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 60.0, autoPlay: true, viewportFraction: 1),
                  items: widget.results.map((movie) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Text(
                              movie.title == null
                                  ? "Not Available"
                                  : "${movie.title}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              movie.releaseDate == null
                                  ? "Not Available"
                                  : "${movie.releaseDate}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }
}
