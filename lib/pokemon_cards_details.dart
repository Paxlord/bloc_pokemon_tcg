import 'package:flutter/material.dart';

import 'Models/pokemontcg_model.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonCard _card;

  const PokemonDetailsPage(this._card);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail page"),
      ),
      body: Center(child: _pokemonCardPage()),
    );
  }

  Widget _pokemonCardPage() {
    return Container(
      child: Column(
        children: [
          Expanded(child: Image.network(_card.imageUrl)),
          Expanded(
            child: _pokemonCardInfos(),
          ),
        ],
      ),
    );
  }

  Widget _pokemonCardInfos() {
    return Container(
      child: Column(
        children: [Text(_card.id), Text(_card.name)],
      ),
    );
  }
}
