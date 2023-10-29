import 'package:flutter/material.dart';
import 'package:moviesapp/shared/network/remote/api_manager.dart';
import 'package:moviesapp/widgets/category_widget.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse Category',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.left,
          ),
          FutureBuilder(
              future: ApiManager.getMoviesCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                var categories = snapshot.data?.genres ?? [];
                return Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6),
                      itemBuilder: (context, index) {
                        return CategoryWidget(categories[index]);
                      },
                      itemCount: categories.length),
                );
              })
        ],
      ),
    );
  }
}
