import 'package:cimenapedia/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:cimenapedia/infraestructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este reposotorio es inmutable

final actorsRepositoryProvider = Provider(
  (ref) => ActorRepositoryImpl(ActorMoviedbDatasource())
);