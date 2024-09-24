

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cimenapedia/domain/entities/movie.dart';
import 'package:cimenapedia/domain/repositories/local_storage_repository.dart';
import 'package:cimenapedia/presentation/providers/storage/local_storage_provider.dart';

final favoriteMoviesProvier = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
Map<int, Movie>
{
  18349: Movie
  18349: Movie
  18349: Movie
}
*/

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository
  }): super({});

  Future<List<Movie>> loadNextPage() async {
    final Map<int, Movie> favoritesMoviesMap = {}; 
    final movies = await localStorageRepository.loadMovies( offset: page * 12, limit: 20);
    page++;

    for (final movie in movies) {
      favoritesMoviesMap[movie.id] = movie;
    }

    state = {...state, ...favoritesMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorite = state[movie.id] != null;

    if (isMovieInFavorite) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
  
}