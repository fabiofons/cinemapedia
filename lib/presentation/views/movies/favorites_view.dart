import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    if (isLoading || isLastPage) return;

    isLoading = true;

    final videos =
        await ref.read(favoriteMoviesProvier.notifier).loadNextPage();
    isLoading = false;

    if (videos.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvier).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_outlined,
              color: colors.primary,
              size: 60,
            ),
            Text(
              'Ohh noo!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const Text(
              "You don't have favorites movies",
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
                onPressed: () {
                  context.go('/home/0');
                },
                child: const Text('Visit home'))
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(
      movies: favoriteMovies,
      loadNextPage: loadNextPage,
    ));
  }
}
