import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/firebase_options.dart';
import 'package:moviesapp/layout/home_layout.dart';
import 'package:moviesapp/screens/category_movies.dart';
import 'package:moviesapp/screens/splash_screen.dart';
import 'package:moviesapp/shared/styles/themes.dart';

import 'screens/movie_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.disableNetwork();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoviesApp',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        CategoryMoviesScreen.routeName: (context) => CategoryMoviesScreen(),
        MovieDetails.routeName: (context) => MovieDetails(),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
      theme: MyThemeData.lightTheme,
    );
  }
}


