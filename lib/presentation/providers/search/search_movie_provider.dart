import 'package:cimenapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cimenapedia/domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<MovieSearchedNotifier, List<Movie>>((ref) {

  final searchMovies = ref.read(movieRepositoryProvider).searchMovies;

  return MovieSearchedNotifier(
    ref: ref, 
    searchMovies: searchMovies
  );
});

typedef SearchMoviesCallback = Future<List<Movie>>Function(String query);

class MovieSearchedNotifier extends StateNotifier<List<Movie>> {

  final SearchMoviesCallback searchMovies;
  final Ref ref;  
  
  MovieSearchedNotifier({
    required this.ref,
    required this.searchMovies
  }): super([]);

  Future<List<Movie>> getMoviesByQuery(String query) async {

    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;

    return movies;
  }
}