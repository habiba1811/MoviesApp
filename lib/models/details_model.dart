import 'package:moviesapp/models/movie_details_response.dart';

class MovieDetailsModel {
  final String movieTitle;
  final num movieId;
  final String poster;
  final String time;
  String? status;
  String? tagline;
  double? voteAverage;
  int? voteCount;
  String? overview;
  double? popularity;
  int? runtime;
  List<Genres>? genres;

  MovieDetailsModel(
      {required this.movieTitle,
      required this.movieId,
      required this.poster,
      required this.time,
      this.overview,
      this.popularity,
      this.tagline,
      this.status,
      this.voteAverage,
      this.voteCount,
      this.runtime,
      this.genres});
}
