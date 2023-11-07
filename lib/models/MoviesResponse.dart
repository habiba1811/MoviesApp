import 'package:moviesapp/models/movie_details_response.dart';

class MoviesResponse {
  MoviesResponse(
      {this.page,
      this.results,
      this.totalPages,
      this.totalResults,
      this.statusCode,
      this.statusMessage,
      this.success});

  MoviesResponse.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    success = json['success'];
  }

  num? page;
  List<Results>? results;
  num? totalPages;
  num? totalResults;
  num? statusCode;
  String? statusMessage;
  bool? success;
}

/// adult : false
/// backdrop_path : "/dZbLqRjjiiNCpTYzhzL2NMvz4J0.jpg"
/// genre_ids : [27,53]
/// id : 951491
/// original_language : "en"
/// original_title : "Saw X"
/// overview : "Between the events of 'Saw' and 'Saw II', a sick and desperate John Kramer travels to Mexico for a risky and experimental medical procedure in hopes of a miracle cure for his cancer, only to discover the entire operation is a scam to defraud the most vulnerable. Armed with a newfound purpose, the infamous serial killer returns to his work, turning the tables on the con artists in his signature visceral way through devious, deranged, and ingenious traps."
/// popularity : 2062.741
/// poster_path : "/aQPeznSu7XDTrrdCtT5eLiu52Yu.jpg"
/// release_date : "2023-09-26"
/// title : "Saw X"
/// video : false
/// vote_average : 7.3
/// vote_count : 379

class Results extends MovieDetailsResponse {
  Results({
    this.genreIds,
  });

  Results.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  @override
  List<int>? genreIds;
}
