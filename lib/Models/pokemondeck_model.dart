import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'pokemondeck_model.g.dart';

@HiveType(typeId: 0)
class PokemonDeck extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<PokemonCard> cards;

  String numberOfCards() {
    return '${cards.length.toString()}/60';
  }

  Color getColor() {
    if (cards.length == 0) {
      return Colors.white;
    }

    return cards[0].mapTypesToColor();
  }

  PokemonDeck(this.name, this.cards);
}
