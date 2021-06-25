import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';
import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:bloc_pokemon_tcg/Services/hive_provider.dart';
import 'package:bloc_pokemon_tcg/Services/pokemontcg_api.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_state.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_state.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonSingleDeckBloc
    extends Bloc<PokemonSingleDeckEvent, PokemonSingleDeckState> {
  PokemonSingleDeckBloc() : super(PokemonSingleDeckInitialState());

  @override
  Stream<PokemonSingleDeckState> mapEventToState(
      PokemonSingleDeckEvent event) async* {
    if (event is PokemonSingleDeckRequestEvent) {
      print(event.deck.name);
      yield PokemonSingleDeckReceivedState(event.deck);
    }

    if (event is PokemonSingleDeckAddCardEvent) {
      PokemonDeck newDeck =
          await HiveProvider.addCardToDeck(event.deck, event.card);
      yield PokemonSingleDeckReceivedState(newDeck);
    }

    if (event is PokemonSingleDeckRemoveEvent) {
      PokemonDeck newDeck =
          await HiveProvider.removeCardFromDeck(event.deck, event.index);
      yield PokemonSingleDeckReceivedState(newDeck);
    }

    if (event is PokemonSingleDeckResetEvent) {
      yield PokemonSingleDeckInitialState();
    }
  }
}
