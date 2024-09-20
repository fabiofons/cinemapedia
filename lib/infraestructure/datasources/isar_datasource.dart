import 'package:cimenapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cimenapedia/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource {
  @override
  Future<bool> isFavoriteMovie(int movieId) {
    // TODO: implement isFavoriteMovie
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

}