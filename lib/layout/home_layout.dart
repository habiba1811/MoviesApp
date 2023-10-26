import 'package:flutter/material.dart';
import 'package:moviesapp/shared/styles/colors.dart';
import 'package:moviesapp/tabs/browse_tab.dart';
import 'package:moviesapp/tabs/home_tab.dart';
import 'package:moviesapp/tabs/watchlist_tab.dart';

import '../tabs/search_tab.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), WatchlistTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (idx) {
          index = idx;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: index == 0 ? MyColors.tapBarIconColor : Colors.white,
              ),
              backgroundColor: MyColors.tapBarColor,
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: index == 1 ? MyColors.tapBarIconColor : Colors.white),
              backgroundColor: MyColors.tapBarColor,
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie,
                  color: index == 2 ? MyColors.tapBarIconColor : Colors.white),
              backgroundColor: MyColors.tapBarColor,
              label: "Browse"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book,
                  color: index == 3 ? MyColors.tapBarIconColor : Colors.white),
              backgroundColor: MyColors.tapBarColor,
              label: "Watchlist"),
        ],
      ),
      body: tabs[index],
    );
  }
}
