import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';
import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:bloc_pokemon_tcg/Services/hive_provider.dart';
import 'package:bloc_pokemon_tcg/Services/pokemontcg_api.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_state.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDeckBloc extends Bloc<PokemonDeckEvent, PokemonDeckState> {
  PokemonDeckBloc() : super(PokemonDeckInitialState());

  @override
  Stream<PokemonDeckState> mapEventToState(PokemonDeckEvent event) async* {
    if (event is PokemonDecksRequestEvent) {
      yield PokemonDeckLoadingState();

      final List<PokemonDeck> decks = await HiveProvider.getAllFromBox();
      yield PokemonDeckReceivedState(decks);
    }

    if (event is PokemonDecksAddEvent) {
      yield PokemonDeckLoadingState();

      await HiveProvider.addToBox(event.deck);
      final List<PokemonDeck> decks = await HiveProvider.getAllFromBox();
      yield PokemonDeckReceivedState(decks);
    }

    if (event is PokemonDecksResetEvent) {
      yield PokemonDeckInitialState();
    }
  }
}
