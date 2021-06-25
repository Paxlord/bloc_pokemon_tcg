import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';
import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';

class PokemonSingleDeckEvent {}

class PokemonSingleDeckRequestEvent extends PokemonSingleDeckEvent {
  PokemonDeck deck;

  PokemonSingleDeckRequestEvent(this.deck);
}

class PokemonSingleDeckResetEvent extends PokemonSingleDeckEvent {}

class PokemonSingleDeckAddCardEvent extends PokemonSingleDeckEvent {
  PokemonDeck deck;
  PokemonCard card;

  PokemonSingleDeckAddCardEvent(this.deck, this.card);
}

class PokemonSingleDeckRemoveEvent extends PokemonSingleDeckEvent {
  PokemonDeck deck;
  int index;

  PokemonSingleDeckRemoveEvent(this.deck, this.index);
}
