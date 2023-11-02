import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moviesapp/shared/styles/colors.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Map<String, dynamic>> searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  final String apiKey = "2c7279c9a62f6ecbb67b38d19315d7f6";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: MyColors.whiteColor),
              controller: _searchController,
              onChanged: (query) {
                if (query.isNotEmpty) {
                  _searchMovies(query);
                }
              },
              decoration: InputDecoration(
                labelText: 'Search for a movie',
                labelStyle: TextStyle(color: MyColors.whiteColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(color: MyColors.whiteColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(color: MyColors.whiteColor),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: BorderSide(color: MyColors.whiteColor)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                final title = movie['title'];
                final releaseDate = movie['release_date'];
                final imageUrl =
                    'https://image.tmdb.org/t/p/w185${movie['poster_path']}';

                return Card(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.network(imageUrl, width: 80.0),
                        title: Text(
                          title,
                          style: TextStyle(
                            color: MyColors.whiteColor,
                          ),
                        ),
                        subtitle: Text(
                          releaseDate,
                          style: TextStyle(
                            color: MyColors.whiteColor,
                          ),
                        ),
                      ),
                      Divider(color: MyColors.whiteColor),
                      // Add a Divider below the ListTile
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      setState(() {
        searchResults = (json.decode(response.body)['results'] as List)
            .cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load movie data');
    }
  }
}
