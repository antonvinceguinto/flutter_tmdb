import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/src/states/popular_movie_state.dart';
import 'package:tmdb/src/states/popular_tv_state.dart';
import 'package:tmdb/src/states/showing_movie_state.dart';
import 'package:tmdb/src/states/upcoming_movie_state.dart';
import 'home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ShowingMovieState>(
            builder: (_) => ShowingMovieState(),
          ),
          ChangeNotifierProvider<PopularMovieState>(
            builder: (_) => PopularMovieState(),
          ),
          ChangeNotifierProvider<UpcomingMovieState>(
            builder: (_) => UpcomingMovieState(),
          ),
          ChangeNotifierProvider<PopularTvState>(
            builder: (_) => PopularTvState(),
          ),
        ],
        child: Home(),
      ),
    );
  }
}
