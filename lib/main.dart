import 'package:bloc_pokemon_tcg/bloc/pokemontcg_bloc.dart';
import 'package:bloc_pokemon_tcg/pokemon_cards_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider<PokemonCardBloc>(
      create: (context) => PokemonCardBloc(),
      child: PokemonCardsPage(),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
