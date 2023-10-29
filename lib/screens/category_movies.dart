import 'package:flutter/material.dart';
import 'package:moviesapp/models/CategoriesResponse.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';
import 'package:moviesapp/shared/styles/colors.dart';
import 'package:moviesapp/widgets/movie_widget.dart';

class CategoryMoviesScreen extends StatelessWidget {
  static String routeName = 'category_movies';

  CategoryMoviesScreen();

  @override
  Widget build(BuildContext context) {
    var genresModel = ModalRoute.of(context)?.settings.arguments as GenresModel;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            genresModel.name ?? '',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.left,
          ),
          FutureBuilder(
              future: ApiManager.getMoviesByCategory(genresModel.name ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                var movies = snapshot.data?.results ?? [];
                return Expanded(
                    child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 5,
                      color: MyColors.whiteColor,
                    );
                  },
                  itemBuilder: (context, index) {
                    return MovieWidget(movies[index]);
                  },
                  itemCount: movies.length,
                ));
              })
        ],
      ),
    );
  }
}
