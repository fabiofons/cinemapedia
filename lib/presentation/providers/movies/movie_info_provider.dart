

import 'package:cimenapedia/domain/entities/movie.dart';
import 'package:cimenapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapProvider, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider).getMovieDetails;

  return MovieMapProvider(getMovie: getMovie);
});

/*
  {
    'movieId': Movie,
    'movieId': Movie,
    'movieId': Movie,
    'movieId': Movie
  }
*/

typedef GetMovieCallback = Future<Movie>Function(String movieId);


class MovieMapProvider extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie; 

  MovieMapProvider({
    required this.getMovie
  }): super({});

  Future<void> loadMovie(String movieId) async {
    if(state[movieId] != null) return;

    print('realizando petición http');

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }

}