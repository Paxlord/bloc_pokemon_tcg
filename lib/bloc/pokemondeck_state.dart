import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';

class PokemonDeckState {}

class PokemonDeckInitialState extends PokemonDeckState {}

class PokemonDeckLoadingState extends PokemonDeckState {}

class PokemonDeckReceivedState extends PokemonDeckState {
  List<PokemonDeck> decks;

  PokemonDeckReceivedState(this.decks);
}
