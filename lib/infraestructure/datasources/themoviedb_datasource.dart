import 'package:cimenapedia/config/constants/enviroment.dart';
import 'package:cimenapedia/domain/datasources/movies_datasource.dart';
import 'package:cimenapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class ThemoviedbDatasource extends MoviesDatasource {

  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Enviroment.theMovieDbKey,
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movies/now_playing');

    final List<Movie> movies = [];
    
    return movies;
  }
}
