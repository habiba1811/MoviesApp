import 'package:flutter/material.dart';
import 'package:moviesapp/shared/components/Widgets/movies_row.dart';

class HomeTab extends StatefulWidget {

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          children: [
            Text(
              "Popular",
              style: TextStyle(color: Colors.white),
            )
          ],
        )),
        Expanded(child: MoviesRow("New Releases", 1)),
        Expanded(child: MoviesRow("Recommended", 2)),
      ],
    );
  }
}
