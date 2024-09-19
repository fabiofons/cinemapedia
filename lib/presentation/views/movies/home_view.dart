import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cimenapedia/presentation/providers/providers.dart';
import 'package:cimenapedia/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

//para tener acceso al ref, cambiar el state a un consumerState y crear la instancia del nuevo state
class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upComingMoviesProvider);

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
                        movies: upcomingMovies,
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
                        movies: topRatedMovies,
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
