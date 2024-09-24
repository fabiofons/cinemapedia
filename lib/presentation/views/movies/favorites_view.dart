import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cimenapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cimenapedia/presentation/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    loadNextPage();
    super.initState();
  }

  void loadNextPage() async {
    if( isLoading || isLastPage ) return;

    isLoading = true;

    final videos = await ref.read(favoriteMoviesProvier.notifier).loadNextPage();
    isLoading = false;
    
    if(videos.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvier).values.toList();
    // final favoriteMoviesList = favoriteMovies.entries.map( //hard way
    //     (movieId) {
    //       return movieId.value;
    //     }).toList();

    return Scaffold(
      body: MovieMasonry(movies: favoriteMovies, loadNextPage: loadNextPage,)
    );
  }
}
