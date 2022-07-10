import 'package:tmdb_riverpod/src/models/movie.dart';

abstract class IMovie {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getNowPlayingMovies();
}
