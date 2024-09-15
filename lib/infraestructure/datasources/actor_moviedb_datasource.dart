import 'package:dio/dio.dart';

import 'package:cimenapedia/domain/datasources/actors_datasource.dart';
import 'package:cimenapedia/domain/entities/actor.dart';
import 'package:cimenapedia/config/constants/enviroment.dart';
import 'package:cimenapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cimenapedia/infraestructure/models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.moviebdBaseUrl, 
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }
    )
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {

    final response = await dio.get('/movie/$movieId/credits');

    final credits = CreditsResponse.fromJson(response.data);
    final List<Actor> actors = credits.cast
    .map((cast) => ActorMapper.castToEntity(cast))
    .toList();

    return actors;
  }
  
}