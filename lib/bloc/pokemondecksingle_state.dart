import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';

class PokemonSingleDeckState {}

class PokemonSingleDeckInitialState extends PokemonSingleDeckState {}

class PokemonSingleDeckLoadingState extends PokemonSingleDeckState {}

class PokemonSingleDeckReceivedState extends PokemonSingleDeckState {
  PokemonDeck deck;

  PokemonSingleDeckReceivedState(this.deck);
}
