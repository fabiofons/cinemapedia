import 'package:cimenapedia/domain/entities/actor.dart';
import 'package:cimenapedia/presentation/providers/actors/actors_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsbyMovieIdProvider = StateNotifierProvider((ref) {
  final getActorsByMovieId =
      ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorsByMovieNotifier(getActorsByMovieId: getActorsByMovieId);
});

/*
  {
    'movieId': <Actor>[],
    'movieId': <Actor>[],
    'movieId': <Actor>[],
    'movieId': <Actor>[]
  }
*/

typedef GetActorByMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier {
  final GetActorByMovieCallback getActorsByMovieId;

  ActorsByMovieNotifier({required this.getActorsByMovieId}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActorsByMovieId(movieId);

    state = {...state, movieId: actors};
  }
}
