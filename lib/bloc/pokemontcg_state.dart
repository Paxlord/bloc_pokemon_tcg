import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';

class PokemonCardState {}

class PokemonCardInitialState extends PokemonCardState {}

class PokemonCardLoadingState extends PokemonCardState {}

class PokemonCardPageReceivedState extends PokemonCardState {
  final List<PokemonCard> cards;

  PokemonCardPageReceivedState(this.cards);
}
