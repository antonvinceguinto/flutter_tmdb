import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/src/screens/detail_screen.dart';
import 'package:tmdb/src/states/showing_movie_state.dart';

class ShowingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShowingMovieState>(
      builder: (context, movie, _) => Container(
            child: movie.isFetching
                ? _
                : movie.getListResponse() != null
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: movie.getListResponse().length,
                          itemBuilder: (context, index) {
                            return _buildItem(movie, index, context);
                          },
                        ),
                      )
                    : Text("Needs Refresh"),
          ),
    );
  }
}

Widget _buildItem(movie, index, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailScreen(movie, index))
          // SlideRightRoute(widget: DetailScreen(movie, index)),
          );
    },
    child: Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movie.getListResponse()[index]['backdrop_path']}'),
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              height: 70,
              width: 350,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              bottom: 12,
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${movie.getListResponse()[index]['title']}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        '${movie.getListResponse()[index]['release_date']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
