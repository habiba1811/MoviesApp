import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/models/MoviesResponse.dart';
import 'package:moviesapp/shared/components/Widgets/movie_widget.dart';
import 'package:moviesapp/shared/network/local/firebase_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';

class WatchlistTab extends StatelessWidget {
  const WatchlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Watchlist',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.left,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Results>>(
                stream: FirebaseManager.getWatchList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  var movies =
                      snapshot.data?.docs.map((doc) => doc.data()).toList() ??
                          [];
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 10,
                        color: MyColors.whiteColor,
                      );
                    },
                    itemBuilder: (context, index) {
                      return MovieWidget(movies[index]);
                    },
                    itemCount: movies.length,
                  );
                }),
          )
        ],
      ),
    );
  }
}
