import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_state.dart';
import 'package:bloc_pokemon_tcg/pokemon_cards_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonCardsPage extends StatelessWidget {
  const PokemonCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des cartes")),
      body: BlocBuilder<PokemonCardBloc, PokemonCardState>(
          builder: (context, state) {
        if (state is PokemonCardInitialState) {
          context.read<PokemonCardBloc>().add(PokemonCardPageRequestEvent());
        }

        if (state is PokemonCardLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PokemonCardPageReceivedState) {
          return PokemonCardsList(state.cards);
        }

        return Container();
      }),
    );
  }
}

class PokemonCardsList extends StatefulWidget {
  final List<PokemonCard> _cards;

  const PokemonCardsList(this._cards);

  @override
  _PokemonCardsListState createState() => _PokemonCardsListState();
}

class _PokemonCardsListState extends State<PokemonCardsList> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  autocorrect: false,
                  controller: searchController,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<PokemonCardBloc>().add(
                      PokemonCardPageRequestSearchEvent(searchController.text));
                },
                child: Text("Search"),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    _pokemonCardTile(widget._cards[index], context),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 15,
                    ),
                itemCount: widget._cards.length),
          )
        ],
      ),
    );
  }

  Widget _pokemonCardTile(PokemonCard card, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PokemonDetailsPage(card)));
      },
      child: Card(
        child: ListTile(
          leading: Image.network(card.imageUrl),
          title: Text(card.name),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
