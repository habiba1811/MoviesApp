import 'package:flutter/material.dart';
import 'package:moviesapp/models/CategoriesResponse.dart';
import 'package:moviesapp/screens/category_movies.dart';
import 'package:moviesapp/shared/styles/colors.dart';

class CategoryWidget extends StatelessWidget {
  GenresModel genresModel;

  CategoryWidget(this.genresModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, CategoryMoviesScreen.routeName,
          arguments: genresModel),
      child: Card(
        elevation: 12,
        margin: EdgeInsets.all(20),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/images/cat.jpg',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            Container(
                decoration: BoxDecoration(
                    color: MyColors.tapBarColor,
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(genresModel.name ?? '',
                    style: Theme.of(context).textTheme.bodyLarge))
          ],
        ),
      ),
    );
  }
}
