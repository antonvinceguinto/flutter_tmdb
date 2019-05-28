import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('Now Showing',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Avenir', color: Colors.white)),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.monochrome_photos,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
