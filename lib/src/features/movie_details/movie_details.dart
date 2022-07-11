import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_riverpod/src/models/movie.dart';

class MovieDetails extends ConsumerWidget {
  const MovieDetails({super.key});

  static const routeName = '/movie-details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /**
     * We passed the movie arguments from homepage to this page. 
    **/
    final movie = ModalRoute.of(context)!.settings.arguments! as Movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                movie.fullImageUrlHD,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (movie.voteAverage != 0) ...{
                      Text(
                        '${movie.voteAverage}/10',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    },
                    if (movie.releaseDate != '')
                      Text(
                        movie.releaseDate,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    const SizedBox(height: 8),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
