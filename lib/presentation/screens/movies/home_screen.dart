import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cimenapedia/presentation/widgets/widgets.dart';
import 'package:cimenapedia/presentation/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

//para tener acceso al ref, cambiar el state a un consumerState y crear la instancia del nuevo state
class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) => Column(
                  children: [
                    // const CustomAppbar(),
                    MoviesSlideshow(movies: slideShowMovies),
                    MovieHorizontalListview(
                        title: 'En cines',
                        subtitle: 'Lunes 20',
                        movies: nowPlayingMovies,
                        loadNextPage: () => ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage()),
                    MovieHorizontalListview(
                        title: 'Upcoming',
                        subtitle: 'This Month',
                        movies: nowPlayingMovies,
                        loadNextPage: () => ref
                            .read(upComingMoviesProvider.notifier)
                            .loadNextPage()),
                    MovieHorizontalListview(
                        title: 'Populars',
                        // subtitle: 'This Month',
                        movies: popularMovies,
                        loadNextPage: () => ref
                            .read(popularMoviesProvider.notifier)
                            .loadNextPage()),
                    MovieHorizontalListview(
                        title: 'Top rated',
                        subtitle: 'of all Times',
                        movies: nowPlayingMovies,
                        loadNextPage: () => ref
                            .read(topRatedMoviesProvider.notifier)
                            .loadNextPage()),
                    const SizedBox(height: 10)
                  ],
                )),
      )
    ]);
  }
}
