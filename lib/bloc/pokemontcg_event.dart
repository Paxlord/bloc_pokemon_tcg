class PokemonCardEvent {}

class PokemonCardPageRequestEvent extends PokemonCardEvent {}

class PokemonCardRequestEvent extends PokemonCardEvent {}

class PokemonCardPageRequestSearchEvent extends PokemonCardEvent {
  String q;

  PokemonCardPageRequestSearchEvent(this.q);
}
