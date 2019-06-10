import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb/src/styles/text_style_title.dart';

class DetailScreen extends StatefulWidget {
  // final movie;
  final String posterUrl;
  final String title;
  final String description;

  DetailScreen({
    this.posterUrl,
    this.title,
    this.description,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState(
        posterUrl: posterUrl,
        title: title,
        description: description,
      );
}

class _DetailScreenState extends State<DetailScreen> {
  final String posterUrl;
  final String title;
  final String description;

  _DetailScreenState({
    this.posterUrl,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _buildBody(context, widget.posterUrl, widget.title),
      ),
    );
  }
}

Widget _buildBody(context, posterUrl, title) {
  return Column(
    children: <Widget>[
      Expanded(
        child: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 350,
                  child: Image(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(posterUrl),
                  ),
                ),
                Container(
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
                  margin: EdgeInsets.only(top: 60, left: 20, right: 20),
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
            Container(
              margin: EdgeInsets.only(top: 300),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: Container(
                        width: double.infinity,
                        color: Color(0xFF192a56),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildGenreChips(),
                            _buildTextHeaders(title),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

_buildGenreChips() {
  return Container(
    padding: EdgeInsets.only(top: 30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildChip('Action'),
        _buildChip('Drama'),
        _buildChip('Comedy'),
      ],
    ),
  );
}

_buildChip(String title) {
  return Container(
    margin: EdgeInsets.only(left: 22),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    decoration: BoxDecoration(
      color: Color(0xFFecf0f1),
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFF2c3e50),
      ),
    ),
  );
}

_buildTextHeaders(String title) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 30, bottom: 20, left: 20),
    child: Text(
      title,
      style: headerTextStyleDetail,
    ),
  );
}
