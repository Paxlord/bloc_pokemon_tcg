import 'package:bloc_pokemon_tcg/bloc/pokemondeck_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondeck_state.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemondecksingle_state.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Models/pokemondeck_model.dart';
import 'Models/pokemontcg_model.dart';

class MyDetailsPage extends StatefulWidget {
  PokemonDeck _deck;

  MyDetailsPage(this._deck);

  @override
  _MyDetailsPageState createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  FixedExtentScrollController _scrollController = FixedExtentScrollController();
  Color deckViewColor = Colors.blue;
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._deck.name),
      ),
      body: _mainView(context),
    );
  }

  @override
  Widget _mainView(BuildContext context) {
    return BlocBuilder<PokemonSingleDeckBloc, PokemonSingleDeckState>(
      builder: (context, state) {
        if (state is PokemonSingleDeckInitialState) {
          context
              .read<PokemonSingleDeckBloc>()
              .add(PokemonSingleDeckRequestEvent(widget._deck));
        }

        if (state is PokemonSingleDeckReceivedState) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: _deckListViewer(context, state.deck),
                  flex: 6,
                ),
                Expanded(
                  child: _cardExplorer(context, state.deck),
                  flex: 4,
                ),
              ],
            ),
          );
        }

        return Text("Erreur fatale, no deck selected");
      },
    );
  }

  Widget _cardExplorer(BuildContext context, PokemonDeck deck) {
    return BlocBuilder<PokemonCardBloc, PokemonCardState>(
      builder: (context, state) {
        if (state is PokemonCardPageReceivedState) {
          return Container(
            margin: EdgeInsets.all(8),
            child: GridView.count(
              crossAxisCount: 2,
              children: state.cards
                  .map((card) => _cardTile(context, card, deck))
                  .toList(),
              scrollDirection: Axis.horizontal,
            ),
          );
        }

        return Text("No card state available");
      },
    );
  }

  Widget _cardTile(BuildContext context, PokemonCard card, PokemonDeck deck) {
    return GestureDetector(
      onDoubleTap: () {
        context
            .read<PokemonSingleDeckBloc>()
            .add(PokemonSingleDeckAddCardEvent(deck, card));

        if (deck.cards.length > 0) {
          _scrollController.jumpToItem(1);
          _scrollController.animateToItem(deck.cards.length,
              duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
        }
      },
      child: Image.network(card.imageUrl),
    );
  }

  Widget _deckListViewer(BuildContext context, PokemonDeck deck) {
    return Container(
      color: deckViewColor,
      child: Row(
        children: [
          Expanded(child: _deckStats(context, deck)),
          Expanded(child: _deckList(deck)),
        ],
      ),
    );
  }

  Widget _deckList(PokemonDeck deck) {
    if (deck.cards.length == 0) {
      return Center(
        child: Text("Pas de cartes dans le deck"),
      );
    }

    return ListWheelScrollView(
      itemExtent: 275,
      offAxisFraction: -1.5,
      controller: _scrollController,
      physics: FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        setState(() {
          deckViewColor = deck.cards[index].mapTypesToColor();
          _selectedIndex = index;
        });
        print(deck.cards[index]);
      },
      children: deck.cards
          .map(
            (card) => Image.network(card.imageUrl),
          )
          .toList(),
    );
  }

  Widget _deckStats(BuildContext context, PokemonDeck deck) {
    if (deck.cards.length > 0) {
      return Container(
        child: Card(
          elevation: 8,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Nombre de cartes"),
              Text("${deck.cards.length}/60"),
              Spacer(),
              Text(
                deck.cards[_selectedIndex].name,
                style: TextStyle(
                  color: deck.cards[_selectedIndex].mapTypesToColor(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<PokemonSingleDeckBloc>().add(
                        PokemonSingleDeckRemoveEvent(deck, _selectedIndex),
                      );
                },
                child: Text("Supprimer cette carte"),
              ),
            ],
          ),
        ),
      );
    }

    return Text(
      "Ajouter une carte pour voir les stats",
      textAlign: TextAlign.center,
    );
  }
}
