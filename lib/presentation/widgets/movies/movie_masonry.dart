import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cimenapedia/domain/entities/movie.dart';
import 'package:cimenapedia/presentation/widgets/movies/movie_post_link.dart';

class MovieMasonry extends StatefulWidget {

  final List<Movie> movies;
  final VoidCallback? loadNextPage; 

  const MovieMasonry({
    super.key, 
    required this.movies, 
    this.loadNextPage
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {

  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if( widget.loadNextPage == null ) return;

      if( scrollController.position.pixels + 100 >= scrollController.position.maxScrollExtent ) {
        widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final Movie movie = widget.movies[index];
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40,),
                MoviePostLink(movie: movie)
              ],
            );
          }
          return MoviePostLink(movie: movie);
        },
      ),
    );
  }
}