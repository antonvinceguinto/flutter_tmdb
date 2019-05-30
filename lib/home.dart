import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/src/clippers/custom_clipper.dart';
import 'package:tmdb/src/states/popular_movie_state.dart';
import 'package:tmdb/src/states/popular_tv_state.dart';
import 'package:tmdb/src/states/showing_movie_state.dart';
import 'package:tmdb/src/states/upcoming_movie_state.dart';
import 'package:tmdb/src/styles/text_style_title.dart';
import 'package:tmdb/src/widgets/appbar.dart';
import 'package:tmdb/src/widgets/popular_movie_grid.dart';
import 'package:tmdb/src/widgets/popular_tv_list.dart';
import 'package:tmdb/src/widgets/showing_movie_list.dart';
import 'package:tmdb/src/widgets/upcoming_movie.dart';

class Home extends StatefulWidget {
  createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final showingState = Provider.of<ShowingMovieState>(context);
    final popularState = Provider.of<PopularMovieState>(context);
    final upcomingState = Provider.of<UpcomingMovieState>(context);
    final popularTvState = Provider.of<PopularTvState>(context);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            showingState.fetchMovies();
            popularState.fetchMovies();
            upcomingState.fetchMovies();
            popularTvState.fetchMovies();
            await _dismiss();
          },
          child: ListView(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: CustomShapeClipper(),
                        child: Container(
                          height: 330,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.redAccent, Colors.deepOrange],
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        children: <Widget>[
                          MyAppBar(),
                          ShowingList(),
                          Container(
                            margin: EdgeInsets.only(top: 60),
                            child: _buildTextHeaders('Popular Movies'),
                          ),
                          PopularList(),
                          _buildTextHeaders('Upcoming Movies'),
                          UpcomingList(),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child:
                                _buildTextHeaders('TV Series you might like'),
                          ),
                          PopularTvList(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  Future<void> _dismiss() {
    return Future.delayed(Duration(seconds: 4),
        () => _refreshIndicatorKey.currentState.deactivate());
  }
}

_buildTextHeaders(String title) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20),
    child: Text(
      title,
      style: headerTextStyle,
    ),
  );
}
