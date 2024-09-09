
import 'package:cimenapedia/infraestructure/datasources/themoviedb_datasource.dart';
import 'package:cimenapedia/infraestructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Este reposotorio es inmutable
final movieRepositoryProvider = Provider(
  (ref) => MovieRepositoryImpl(ThemoviedbDatasource())
);