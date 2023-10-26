import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviesapp/models/NewReleasesResponse.dart';

import '../../../models/popularResponse.dart';

//"https://api.themoviedb.org/3/movie/popular?language=en-US&page=1"
class ApiManager {
  static Future<PopularResponse> getPopular() async {
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
      PopularResponse popularResponse = PopularResponse.fromJson(jsonData);
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
      print("Hellllllllooooooooooooo");
      http.Response response = await http.get(url, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWZjYjMxYWQ3ZGFlNGIyMDJmZmQyNTU2YWFmYTIyNyIsInN1YiI6IjY1M2E2MTJlMDkxZTYyMDBhY2JkNWU0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ugMLj-4o4TAcgVy-M-rhWcQcWPosyuSNQVIY10ADlVY"
      });
      print("It'sssssss meeeeeeeeeeeeeeeeeeeeeeeeeeee");
      var jsonData = jsonDecode(response.body);
      print("I waaaaas wonderrrrrrring");
      NewReleasesResponse newReleasesResponse =
          NewReleasesResponse.fromJson(jsonData);
      print("Ifffff afterrrrr allllllll theeeseeeeee");
      return newReleasesResponse;
    } catch (e) {
      print("yearsssssss you'd like tooooooo meeeeeeeeet");
      print(e.toString());
      throw Exception();
    }
  }
}
