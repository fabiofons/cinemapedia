import 'package:animate_do/animate_do.dart';
import 'package:cimenapedia/config/helpers/humans_format.dart';
import 'package:cimenapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;


  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subtitle, 
    this.loadNextPage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener((){
      if(widget.loadNextPage == null) return;

      if(scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.title != null || widget.subtitle != null)
            _Title(widget.title, widget.subtitle),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.movies.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => FadeInRight(child: _Slide(movie: widget.movies[index]))
              ),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 225,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2, style: textStyles.titleSmall),
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                Text(HumansFormat.votes(movie.voteAverage), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow[800]),),
                const Spacer(),
                Text('Popular: ${HumansFormat.number(movie.popularity)}', style: textStyles.bodySmall),
              ]
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _Title(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(  
        children: [
          if(title != null)
            Text(title!, style: titleStyle,),
          const Spacer(),
          if(subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: (){}, 
              child: Text(subtitle!)
            ),
        ],
      ),
    );
  }
}