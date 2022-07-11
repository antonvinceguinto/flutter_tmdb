import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_riverpod/src/features/movie_details/movie_details.dart';
import 'package:tmdb_riverpod/src/repositories/movie_service.dart';
import 'package:tmdb_riverpod/src/utils/errors/movies_exception.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ref.watch(moviesFutureProvider).when(
            data: (movies) {
              return RefreshIndicator(
                onRefresh: () {
                  return ref.refresh(moviesFutureProvider.future);
                },
                child: GridView.extent(
                  maxCrossAxisExtent: 300,
                  padding: const EdgeInsets.all(3),
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.7,
                  children: movies.map((movie) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetails.routeName,
                          arguments: movie,
                        );
                      },
                      child: Image.network(
                        movie.fullImageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            error: (err, s) {
              if (err is MoviesException) {
                return Center(
                  child: Text('${err.message}'),
                );
              }
              return const Center(
                child: Text('Oops, Something went wrong'),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
