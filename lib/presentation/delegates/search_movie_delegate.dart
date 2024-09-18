import 'package:flutter/material.dart';
import 'dart:async';

import 'package:animate_do/animate_do.dart';

import 'package:cimenapedia/config/helpers/humans_format.dart';
import 'package:cimenapedia/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);
class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies
  });

  void _onQueryChanged(String query) {
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if(query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
    });
  }

  void clearStreams () {
    debouncedMovies.close();
  }


  @override
  String get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () => query = '', 
          icon: const Icon(Icons.close_rounded)
        )
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back_ios_new_outlined)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return StreamBuilder(
      stream: debouncedMovies.stream, 
      builder:(context, snapshot) {

        //! print('Realizando peticion');
        
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie, 
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              }
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function(BuildContext context, Movie movie) onMovieSelected;

  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  fit: BoxFit.cover,
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length < 100)
                  ? Text(movie.overview)
                  : Text('${movie.overview.substring(0,100)}...', maxLines: 3,),
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                      const SizedBox(width: 5,),
                      Text(
                        HumansFormat.votes(movie.voteAverage), 
                        style: textStyle.bodyMedium!.copyWith(color: Colors.yellow.shade900)
                      )
                    ],
                  )
                ],
              ))
            
          ],
        ),
      ),
    );
  }
}