import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_riverpod/src/features/home/movie_service.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ref.watch(moviesFutureProvider).when(
            data: (movies) {
              return RefreshIndicator(
                onRefresh: () =>
                    ref.read(movieServiceProvider).getPopularMovies(),
                child: GridView.extent(
                  maxCrossAxisExtent: 300,
                  padding: const EdgeInsets.all(3),
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.7,
                  children: movies.map((movie) {
                    return Image.network(
                      movie.fullImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  }).toList(),
                ),
              );
            },
            error: (err, s) {
              return Center(
                child: Text('Err occured $err'),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
