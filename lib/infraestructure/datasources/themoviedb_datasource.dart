import 'package:dio/dio.dart';

import 'package:cimenapedia/config/constants/enviroment.dart';
import 'package:cimenapedia/domain/datasources/movies_datasource.dart';
import 'package:cimenapedia/domain/entities/movie.dart';
import 'package:cimenapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cimenapedia/infraestructure/models/moviedb/moviedb_response.dart';

class ThemoviedbDatasource extends MoviesDatasource {

  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Enviroment.theMovieDbKey,
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movies/now_playing');
    final movieDBResponse = MoviesDBResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.backdropPath != 'no-backdrop')
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
    .toList();
    
    return movies;
  }
}
