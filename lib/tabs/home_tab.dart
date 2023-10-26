import 'package:flutter/material.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: ApiManager.getRecommended(),
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
              print(
                  "success issssssssssssssssssss ${snapshot.data?.totalResults ?? []}");
              return Expanded(
                  child: ListView.builder(
                itemCount: UpcomingMovies.length,
                itemBuilder: (context, index) {
                  return Text(
                    UpcomingMovies[index].title ?? "",
                    style: TextStyle(color: Colors.white),
                  );
                },
              ));
            }),
      ],
    );
  }
}
