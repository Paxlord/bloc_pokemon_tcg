import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';
import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:hive/hive.dart';

class HiveProvider {
  static Future<Box<PokemonDeck>> getDeckBox() async {
    if (!Hive.isBoxOpen('decks')) {
      await Hive.openBox<PokemonDeck>("decks");
    }

    return Hive.box<PokemonDeck>("decks");
  }

  static Future addToBox(PokemonDeck deck) async {
    var box = await getDeckBox();

    await box.add(deck);
  }

  static Future removeFromBox(PokemonDeck deck) async {
    await deck.delete();
  }

  static Future<List<PokemonDeck>> getAllFromBox() async {
    var box = await getDeckBox();
    return box.values.toList().cast<PokemonDeck>();
  }

  static Future<PokemonDeck> addCardToDeck(
      PokemonDeck deck, PokemonCard card) async {
    deck.cards.add(card);

    await deck.save();
    return deck;
  }

  static Future<PokemonDeck> removeCardFromDeck(
      PokemonDeck deck, int index) async {
    deck.cards.removeAt(index);

    await deck.save();
    return deck;
  }
}
