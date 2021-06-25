/* 
  "data": [
        {
            "id": "pl1-1",
            "name": "Ampharos",
            "supertype": "Pokémon",
            "subtypes": [
                "Stage 2"
            ],
            "level": "57",
            "hp": "130",
            "types": [
                "Lightning"
            ],
            "evolvesFrom": "Flaaffy",
            "abilities": [
                {
                    "name": "Damage Bind",
                    "text": "Each Pokémon that has any damage counters on it (both yours and your opponent's) can't use any Poké-Powers.",
                    "type": "Poké-Body"
                }
            ],
            "attacks": [
                {
                    "name": "Gigavolt",
                    "cost": [
                        "Lightning",
                        "Colorless"
                    ],
                    "convertedEnergyCost": 2,
                    "damage": "30+",
                    "text": "Flip a coin. If heads, this attack does 30 damage plus 30 more damage. If tails, the Defending Pokémon is now Paralyzed."
                },
                {
                    "name": "Reflect Energy",
                    "cost": [
                        "Lightning",
                        "Colorless",
                        "Colorless"
                    ],
                    "convertedEnergyCost": 3,
                    "damage": "70",
                    "text": "Move an Energy card attached to Ampharos to 1 of your Benched Pokémon."
                }
            ],
            "weaknesses": [
                {
                    "type": "Fighting",
                    "value": "+30"
                }
            ],
            "resistances": [
                {
                    "type": "Metal",
                    "value": "-20"
                }
            ],
            "retreatCost": [
                "Colorless",
                "Colorless"
            ],
            "convertedRetreatCost": 2,
            "set": {
                "id": "pl1",
                "name": "Platinum",
                "series": "Platinum",
                "printedTotal": 127,
                "total": 130,
                "legalities": {
                    "unlimited": "Legal"
                },
                "ptcgoCode": "PL",
                "releaseDate": "2009/02/11",
                "updatedAt": "2020/08/14 09:35:00",
                "images": {
                    "symbol": "https://images.pokemontcg.io/pl1/symbol.png",
                    "logo": "https://images.pokemontcg.io/pl1/logo.png"
                }
            },
            "number": "1",
            "artist": "Atsuko Nishida",
            "rarity": "Rare Holo",
            "nationalPokedexNumbers": [
                181
            ],
            "legalities": {
                "unlimited": "Legal"
            },
            "images": {
                "small": "https://images.pokemontcg.io/pl1/1.png",
                "large": "https://images.pokemontcg.io/pl1/1_hires.png"
            },
            "tcgplayer": {
                "url": "https://prices.pokemontcg.io/tcgplayer/pl1-1",
                "updatedAt": "2021/06/14",
                "prices": {
                    "holofoil": {
                        "low": 6.75,
                        "mid": 8.0,
                        "high": 14.98,
                        "market": 6.96,
                        "directLow": 14.98
                    },
                    "reverseHolofoil": {
                        "low": 2.0,
                        "mid": 13.91,
                        "high": 14.98,
                        "market": 2.12,
                        "directLow": null
                    }
                }
            }
        },

*/

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'pokemontcg_model.g.dart';

class PokemonCardAbility {
  final String name;
  final String text;

  PokemonCardAbility(this.name, this.text);
  PokemonCardAbility.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        text = json["text"];
}

@HiveType(typeId: 1)
class PokemonCard extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imageUrl;

  @HiveField(4)
  final String imageUrl_Big;

  @HiveField(2)
  final String id;

  //final List<PokemonCardAbility> abilities;
  @HiveField(3)
  final List<String> types;

  PokemonCard(this.name, this.imageUrl, this.id, this.types, this.imageUrl_Big);
  PokemonCard.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        imageUrl = json["images"]["small"],
        imageUrl_Big = json["images"]["large"],
        id = json["id"],
        types = (json["types"] as List).map((type) => type as String).toList();

  Color mapTypesToColor() {
    switch (types[0]) {
      case "Fighting":
        return Colors.brown;
      case "Flying":
        return Colors.lightBlue[200]!;
      case "Poison":
        return Colors.purple;
      case "Ground":
        return Colors.brown[300]!;
      case "Rock":
        return Colors.brown[800]!;
      case "Bug":
        return Colors.green[200]!;
      case "Ghost":
        return Colors.purple[200]!;
      case "Metal":
        return Colors.grey;
      case "Fire":
        return Colors.red;
      case "Water":
        return Colors.blue;
      case "Grass":
        return Colors.green;
      case "Lightning":
        return Colors.yellow;
      case "Psychic":
        return Colors.purple[800]!;
      case "Ice":
        return Colors.blue[200]!;
      case "Dragon":
        return Colors.deepPurple;
      case "Fairy":
        return Colors.pink;
      case "Darkness":
        return Colors.deepPurple[900]!;
    }

    return Colors.black;
  }

  @override
  String toString() {
    return "Nom : $name, Type principal: ${types[0]}, id: $id, image_url: $imageUrl, image_urlBig: $imageUrl_Big";
  }
}

class PokemonCardPage {
  final List<PokemonCard> cards;

  PokemonCardPage(this.cards);

  PokemonCardPage.fromJson(Map<String, dynamic> json)
      : cards = (json["data"] as List)
            .map((element) => PokemonCard.fromJson(element))
            .toList();
}
