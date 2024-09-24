import 'package:cimenapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isFavoriteMovie(int movieId);

  Future<List<Movie>> loadMovies({int limit = 12, int offset=0});
}