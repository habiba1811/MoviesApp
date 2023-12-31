import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviesapp/models/CategoriesResponse.dart';
import 'package:moviesapp/models/NewReleasesResponse.dart';
import 'package:moviesapp/models/movie_details_response.dart';
import 'package:moviesapp/models/similar_response.dart';

import '../../../models/MoviesResponse.dart';

//"https://api.themoviedb.org/3/movie/popular?language=en-US&page=1"
class ApiManager {
  static Future<MoviesResponse> getPopular() async {
    try {
      Uri url = Uri.https(
        "api.themoviedb.org",
        "/3/movie/popular",
        {"language": "en-US"},
      );
      http.Response response = await (http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      }));
      var jsonData = jsonDecode(response.body);
      MoviesResponse popularResponse = MoviesResponse.fromJson(jsonData);
      return popularResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<NewReleasesResponse> getUpcoming() async {
    try {
      Uri url = Uri.https(
          "api.themoviedb.org", "/3/movie/upcoming", {"language": "en-US"});
      http.Response response = await http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      });
      var jsonData = jsonDecode(response.body);
      NewReleasesResponse newReleasesResponse =
          NewReleasesResponse.fromJson(jsonData);
      return newReleasesResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<MoviesResponse> getRecommended() async {
    try {
      Uri url = Uri.https(
        "api.themoviedb.org",
        "/3/movie/top_rated",
        {"language": "en-US"},
      );
      http.Response response = await (http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      }));
      var jsonData = jsonDecode(response.body);
      MoviesResponse popularResponse = MoviesResponse.fromJson(jsonData);
      return popularResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<CategoriesResponse> getMoviesCategories() async {
    try {
      Uri url = Uri.https(
        "api.themoviedb.org",
        "/3/genre/movie/list",
        {"language": "en-US"},
      );
      http.Response response = await (http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      }));
      var jsonData = jsonDecode(response.body);
      CategoriesResponse categoriesResponse =
          CategoriesResponse.fromJson(jsonData);
      return categoriesResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<MoviesResponse> getMoviesByCategory(num categoryId) async {
    try {
      Uri url = Uri.https(
        "api.themoviedb.org",
        "/3/discover/movie",
        {
          "language": "en-US",
          "with_genres": categoryId.toString(),
          "include_adult": "false",
          "include_video": "false",
          "page": "1"
        },
      );
      http.Response response = await (http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      }));
      var jsonData = jsonDecode(response.body);
      MoviesResponse moviesResponse = MoviesResponse.fromJson(jsonData);
      return moviesResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<MovieDetailsResponse> getMovieDetails(num movieId) async {
    try {
      Uri url = Uri.https(
        "api.themoviedb.org",
        "/3/movie/$movieId",
        {
          "language": "en-US",
        },
      );
      http.Response response = await (http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      }));
      var jsonData = jsonDecode(response.body);
      MovieDetailsResponse movieDetailsResponse =
          MovieDetailsResponse.fromJson(jsonData);
      return movieDetailsResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<SimilarResponse> getSimilar(num movieId) async {
    try {
      Uri url = Uri.https(
        "api.themoviedb.org",
        "/3/movie/$movieId/similar",
        {"language": "en-US", "page": "1"},
      );
      http.Response response = await (http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      }));
      var jsonData = jsonDecode(response.body);
      SimilarResponse similarResponse = SimilarResponse.fromJson(jsonData);
      return similarResponse;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

}
