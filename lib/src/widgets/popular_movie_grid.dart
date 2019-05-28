import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/src/states/popular_movie_state.dart';

class PopularList extends StatefulWidget {
  @override
  _PopularGridViewState createState() => _PopularGridViewState();
}

class _PopularGridViewState extends State<PopularList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PopularMovieState>(
      builder: (context, movie, _) => SizedBox(
            child: Container(
              child: movie.isFetching
                  ? _
                  : movie.getListResponse() != null
                      ? Container(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.6),
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return _buildItem(movie, index);
                            },
                          ),
                        )
                      : Text("Needs Refresh"),
            ),
          ),
    );
  }
}

Widget _buildItem(movie, index) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Image(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${movie.getListResponse()[index]['poster_path']}'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 8),
          child: Text(
            '${movie.getListResponse()[index]['title']}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontFamily: 'Avenir',
              color: Colors.black87,
              fontSize: 13,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Text(
            'Vote: ${movie.getListResponse()[index]['vote_average']}/10',
            style: TextStyle(
              fontFamily: 'Avenir',
              color: Colors.black54,
              fontSize: 10,
            ),
          ),
        ),
      ],
    ),
  );
}
