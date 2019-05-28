import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final movie;
  final index;

  DetailScreen(this.movie, this.index);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context, widget.movie, widget.index),
    );
  }
}

Widget _buildBody(context, movie, index) {
  return Column(
    children: <Widget>[
      Expanded(
        child: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${movie.getListResponse()[index]['backdrop_path']}'),
                  ),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black38,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black38,
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star_border,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: Container(
                    height: 480,
                    width: double.infinity,
                    color: Colors.red,
                    // child: Text('Anton'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
