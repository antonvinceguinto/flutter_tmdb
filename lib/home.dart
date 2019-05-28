import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/src/clippers/custom_clipper.dart';
import 'package:tmdb/src/states/popular_movie_state.dart';
import 'package:tmdb/src/states/popular_tv_state.dart';
import 'package:tmdb/src/states/showing_movie_state.dart';
import 'package:tmdb/src/states/upcoming_movie_state.dart';
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
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0, // this will be set when a new tab is tapped
      //   fixedColor: Colors.deepOrange,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: ClipRRect(
      //         borderRadius: BorderRadius.all(Radius.circular(100)),
      //         child: Container(
      //           width: 25,
      //           height: 25,
      //           child: Icon(
      //             Icons.hd,
      //             size: 20,
      //           ),
      //         ),
      //       ),
      //       title: Text(
      //         'Home',
      //         style: TextStyle(
      //           fontSize: 13,
      //           fontFamily: 'Oxygen',
      //           fontWeight: FontWeight.w300,
      //         ),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ClipRRect(
      //         borderRadius: BorderRadius.all(Radius.circular(100)),
      //         child: Container(
      //           width: 25,
      //           height: 25,
      //           child: Icon(
      //             Icons.thumb_up,
      //             size: 20,
      //           ),
      //         ),
      //       ),
      //       title: Text(
      //         'Upcoming',
      //         style: TextStyle(
      //           fontSize: 13,
      //           fontFamily: 'Oxygen',
      //           fontWeight: FontWeight.w300,
      //         ),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ClipRRect(
      //         borderRadius: BorderRadius.all(Radius.circular(100)),
      //         child: Container(
      //           width: 25,
      //           height: 25,
      //           child: Icon(
      //             Icons.compare,
      //             size: 20,
      //           ),
      //         ),
      //       ),
      //       title: Text(
      //         'Theatre',
      //         style: TextStyle(
      //           fontSize: 13,
      //           fontFamily: 'Oxygen',
      //           fontWeight: FontWeight.w300,
      //         ),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ClipRRect(
      //         borderRadius: BorderRadius.all(Radius.circular(100)),
      //         child: Container(
      //           width: 25,
      //           height: 25,
      //           child: Icon(
      //             Icons.rate_review,
      //             size: 20,
      //           ),
      //         ),
      //       ),
      //       title: Text(
      //         'Reviews',
      //         style: TextStyle(
      //           fontSize: 13,
      //           fontFamily: 'Oxygen',
      //           fontWeight: FontWeight.w300,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: RefreshIndicator(
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
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 180,
                          child: ShowingList(),
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(top: 80, bottom: 20, left: 20),
                          child: Text('Popular Movies',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Avenir',
                                  color: Colors.black87)),
                        ),
                        Container(
                          child: PopularList(),
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(top: 20, bottom: 20, left: 20),
                          child: Text('Upcoming Movies',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Avenir',
                                  color: Colors.black87)),
                        ),
                        Container(
                          height: 400,
                          child: UpcomingList(),
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(top: 30, bottom: 20, left: 20),
                          child: Text('TV Series you might like',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Avenir',
                                  color: Colors.black87)),
                        ),
                        Stack(
                          children: <Widget>[
                            // ClipPath(
                            //   clipper: CustomShapeClipper(),
                            //   child: Container(
                            //     height: 100,
                            //     decoration: BoxDecoration(
                            //       gradient: LinearGradient(
                            //         colors: [
                            //           Colors.redAccent,
                            //           Colors.deepOrange
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              height: 140,
                              margin: EdgeInsets.only(bottom: 20),
                              child: PopularTvList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
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
