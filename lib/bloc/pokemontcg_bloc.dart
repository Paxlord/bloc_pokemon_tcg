import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:bloc_pokemon_tcg/Services/pokemontcg_api.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonCardBloc extends Bloc<PokemonCardEvent, PokemonCardState> {
  final PokemonTCGDataService _api = PokemonTCGDataService();

  PokemonCardBloc() : super(PokemonCardInitialState());

  @override
  Stream<PokemonCardState> mapEventToState(PokemonCardEvent event) async* {
    if (event is PokemonCardPageRequestEvent) {
      yield PokemonCardLoadingState();

      final PokemonCardPage page = await _api.getPage();
      yield PokemonCardPageReceivedState(page.cards);
    }

    if (event is PokemonCardPageRequestSearchEvent) {
      yield PokemonCardLoadingState();

      final PokemonCardPage page = await _api.getPageWithQ(event.q);
      yield PokemonCardPageReceivedState(page.cards);
    }
  }
}
