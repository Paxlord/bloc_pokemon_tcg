import 'package:bloc_pokemon_tcg/Models/pokemondeck_model.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_state.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_event.dart';
import 'package:bloc_pokemon_tcg/pokemon_cards_decks_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:after_layout/after_layout.dart';

class DecksListPage extends StatefulWidget {
  const DecksListPage({Key? key}) : super(key: key);

  @override
  _DecksListPageState createState() => _DecksListPageState();
}

class _DecksListPageState extends State<DecksListPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    _controller.dispose;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDeckBloc, PokemonDeckState>(
      builder: (context, state) {
        if (state is PokemonDeckInitialState) {
          context.read<PokemonDeckBloc>().add(PokemonDecksRequestEvent());
        }

        if (state is PokemonDeckReceivedState) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: _mainView(context, state.decks),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      _onNewDeckPressed(context);
                    },
                    child: Text("Nouveau Deck"))
              ],
            ),
          );
        }

        return Container(
          child: Text('Erreur fatale'),
        );
      },
    );
  }

  Widget _mainView(BuildContext context, List<PokemonDeck> decks) {
    if (decks.length > 0) {
      return GridView.count(
        clipBehavior: Clip.none,
        childAspectRatio: 0.75,
        crossAxisCount: 2,
        children: decks.map((element) => _deckTile(context, element)).toList(),
      );
    }

    return Center(child: Text("Pas de deck sauvegardés"));
  }

  Widget _deckTile(BuildContext context, PokemonDeck deck) {
    return InkWell(
      onTap: () {
        context
            .read<PokemonSingleDeckBloc>()
            .add(PokemonSingleDeckResetEvent());

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyDetailsPage(deck)))
            .then((value) {
          context.read<PokemonDeckBloc>().add(PokemonDecksResetEvent());
        });
      },
      child: Card(
        color: deck.getColor(),
        clipBehavior: Clip.none,
        elevation: 8,
        child: Container(
          margin: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(deck.name, textAlign: TextAlign.center),
                    Text(
                      deck.numberOfCards(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newDeckTile(BuildContext context) {
    return Card(
      child: Container(
        child: Text("Nouveau deck"),
      ),
    );
  }

  void _onNewDeckPressed(BuildContext context) {
    final myModel = BlocProvider.of<PokemonDeckBloc>(context, listen: false);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider.value(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Nom du deck"),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("press");
                    myModel.add(PokemonDecksAddEvent(
                        PokemonDeck(_controller.text, [])));
                    Navigator.pop(context);
                  },
                  child: Text("Ajouter le nouveau deck"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Annuler"),
                ),
              ],
            ),
            value: myModel,
          );
        });
  }
}
