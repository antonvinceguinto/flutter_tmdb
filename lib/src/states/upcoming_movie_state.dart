import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpcomingMovieState with ChangeNotifier {
  UpcomingMovieState();

  var _jsonResponse = '';
  var _url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=12d23511f39faf4a6a19aaf7f1866e5d&language=en-US&page=1';
  
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  getListResponse() {
    if (_jsonResponse.isNotEmpty) {
      var json = jsonDecode(_jsonResponse);
      return json['results'];
    }

    return null;
  }

  getSingleResponse(String key) {
    if (_jsonResponse.isNotEmpty) {
      var json = jsonDecode(_jsonResponse);
      return json[key];
    }

    return null;
  }

  fetchMovies() async {
    isFetching = true;

    var response = await http.get(_url);

    _jsonResponse = response.body;

    isFetching = false;
  }
}
