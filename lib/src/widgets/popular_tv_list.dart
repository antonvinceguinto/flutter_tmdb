import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/src/states/popular_tv_state.dart';

class PopularTvList extends StatefulWidget {
  @override
  _PopularTvListState createState() => _PopularTvListState();
}

class _PopularTvListState extends State<PopularTvList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PopularTvState>(
      builder: (context, movie, _) => Container(
            child: movie.isFetching
                ? _
                : movie.getListResponse() != null
                    ? Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: movie.getListResponse().length,
                          itemBuilder: (context, index) {
                            return _buildItem(movie, index);
                          },
                        ),
                      )
                    : Text("Needs Refresh"),
          ),
    );
  }
}

Widget _buildItem(movie, index) {
  return Container(
    width: 250,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
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
                Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${movie.getListResponse()[index]['name']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        '${movie.getListResponse()[index]['overview']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
