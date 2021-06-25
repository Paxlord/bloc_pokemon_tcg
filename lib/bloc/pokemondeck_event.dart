import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';
import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';

class PokemonDeckEvent {}

class PokemonDecksRequestEvent extends PokemonDeckEvent {}

class PokemonDecksAddEvent extends PokemonDeckEvent {
  PokemonDeck deck;

  PokemonDecksAddEvent(this.deck);
}

class PokemonDecksResetEvent extends PokemonDeckEvent {}
