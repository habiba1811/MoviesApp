class MovieDetailsModel {
  final String movieTitle;
  final num movieId;
  final String poster;
  final String time;
  final String backdropPath;
  final String overview;
  final num voteAverage;

  //final String genres;

  MovieDetailsModel({
    required this.movieTitle,
    required this.movieId,
    required this.poster,
    required this.time,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
  });
}
