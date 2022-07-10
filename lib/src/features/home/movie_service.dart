import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_riverpod/src/environment_config.dart';
import 'package:tmdb_riverpod/src/features/home/movie_interface.dart';
import 'package:tmdb_riverpod/src/models/movie.dart';
import 'package:tmdb_riverpod/src/utils/errors/movies_exception.dart';

class MovieService extends IMovie {
  MovieService({
    required this.environmentConfig,
    required this.dio,
  });

  final EnvironmentConfig environmentConfig;
  final Dio dio;

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'https://api.themoviedb.org/3/movie/popular',
        queryParameters: {
          'api_key': environmentConfig.movieApiKey,
        },
      );

      final results = List<Map<String, dynamic>>.from(
        response.data!['results'] as Iterable<dynamic>,
      );

      final movies = results.map((movieData) {
        return Movie.fromMap(movieData);
      }).toList(growable: false);

      return movies;
    } on DioError catch (dioErr) {
      throw MoviesException.fromDioError(dioErr);
    }
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() {
    throw UnimplementedError();
  }
}

final movieServiceProvider = Provider<MovieService>(
  (ref) => MovieService(
    environmentConfig: ref.watch(environmentConfigProvider),
    dio: Dio(),
  ),
);

final moviesFutureProvider = FutureProvider.autoDispose<List<Movie>>(
    (AutoDisposeFutureProviderRef<List<Movie>> ref) async {
  ref.maintainState = true;

  final movieService = ref.watch(movieServiceProvider);
  final movies = await movieService.getPopularMovies();
  return movies;
});
