import 'dart:convert';

import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';

import 'package:http/http.dart' as http;

class PokemonTCGDataService {
  final String apiUri = "https://api.pokemontcg.io/v2/cards";
  final String apiKey = "1836385c-7cbd-425c-9ac1-f1fdbe076555";

  Future<PokemonCardPage> getPage() async {
    print("Request started");

    var response =
        await http.get(Uri.parse(apiUri), headers: {"x-api-key": apiKey});

    print("response found ! ");

    final decodedResponse = jsonDecode(response.body);

    return PokemonCardPage.fromJson(decodedResponse);
  }

  Future<PokemonCardPage> getPageWithQ(String q) async {
    print("Request Search started");

    final uri =
        Uri.https('api.pokemontcg.io', '/v2/cards', {'q': 'name:${q.trim()}'});

    print(uri);

    var response = await http.get(uri, headers: {"x-api-key": apiKey});

    print("response Search found ! ");

    final decodedResponse = jsonDecode(response.body);

    return PokemonCardPage.fromJson(decodedResponse);
  }

  Future<PokemonCard> getCard(String id) async {
    var response = await http
        .get(Uri.parse(apiUri + '/$id'), headers: {"x-api-key": apiKey});

    final decodedResponse = jsonDecode(response.body);

    return PokemonCard.fromJson(decodedResponse["data"]);
  }
}
