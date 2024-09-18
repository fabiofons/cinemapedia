
import 'package:cimenapedia/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpComing({int page = 1});
  
  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieDetails(String id);

  Future<List<Movie>> searchMovies(String query);
}
