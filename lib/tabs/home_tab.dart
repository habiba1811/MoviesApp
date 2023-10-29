import 'package:flutter/material.dart';
import 'package:moviesapp/shared/components/Widgets/movies_row.dart';

import '../shared/components/Widgets/carousel.dart';
import '../shared/network/remote/api_manager.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: ApiManager.getPopular(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text("An Error has occured",
                  style: TextStyle(color: Colors.white));
            }
            if (snapshot.data?.success == false) {
              return Text("Failed request check sent parameters",
                  style: TextStyle(color: Colors.white));
            }
            var UpcomingMovies = snapshot.data?.results ?? [];
            return MyCarousel(UpcomingMovies);
          },
        ),
        Expanded(child: MoviesRow("New Releases", 1)),
        Expanded(child: MoviesRow("Recommended", 2)),
      ],
    );
  }
}
