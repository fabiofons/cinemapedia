import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cimenapedia/domain/entities/movie.dart';
import 'package:cimenapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cimenapedia/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final color = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: color.primary),
              const SizedBox(width: 10,),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final storedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchMovieDelegate(
                      initialMovies: storedMovies,
                      searchMovies: ref.read(searchedMoviesProvider.notifier).getMoviesByQuery
                    )
                  ).then((movie) {
                    if(movie == null) return;
                    context.push('/home/0/movie/${movie.id}');
                  });
                }, 
                icon: const Icon(Icons.search)
              )
            ],
          ),
        ),
      )
    );
  }
}