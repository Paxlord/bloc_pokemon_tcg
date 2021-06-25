import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_bloc.dart';
import 'package:bloc_pokemon_tcg/pokemon_cards_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Models/pokemondeck_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PokemonDeckAdapter());
  Hive.registerAdapter(PokemonCardAdapter());

  await Hive.openBox<PokemonDeck>("decks");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonCardBloc>(create: (_) => PokemonCardBloc()),
        BlocProvider<PokemonDeckBloc>(
          create: (_) => PokemonDeckBloc(),
        ),
        BlocProvider<PokemonSingleDeckBloc>(
            create: (_) => PokemonSingleDeckBloc()),
      ],
      child: MaterialApp(
        home: PokemonCardsPage(),
      ),
    );
  }
}
