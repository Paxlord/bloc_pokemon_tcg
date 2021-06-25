import 'package:bloc_pokemon_tcg/Models/pokemontcg_model.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_bloc.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_event.dart';
import 'package:bloc_pokemon_tcg/bloc/pokemontcg_state.dart';
import 'package:bloc_pokemon_tcg/pokemon_cards_decks.dart';
import 'package:bloc_pokemon_tcg/pokemon_cards_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonCardsPage extends StatefulWidget {
  const PokemonCardsPage({Key? key}) : super(key: key);

  @override
  _PokemonCardsPageState createState() => _PokemonCardsPageState();
}

class _PokemonCardsPageState extends State<PokemonCardsPage> {
  int _selectedIndex = 0;

  final List<Widget> _pagesArray = [
    PokemonCardsList(),
    DecksListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des cartes")),
      body: _pagesArray.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Cartes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Mes Decks",
          ),
        ],
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}

class PokemonCardsList extends StatefulWidget {
  @override
  _PokemonCardsListState createState() => _PokemonCardsListState();
}

class _PokemonCardsListState extends State<PokemonCardsList> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCardBloc, PokemonCardState>(
        builder: (context, state) {
      if (state is PokemonCardInitialState) {
        context.read<PokemonCardBloc>().add(PokemonCardPageRequestEvent());
      }

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
                        PokemonCardPageRequestSearchEvent(
                            searchController.text));
                  },
                  child: Text("Search"),
                ),
              ],
            ),
            _buildMainView(state),
          ],
        ),
      );
    });
  }

  Widget _buildMainView(state) {
    if (state is PokemonCardLoadingState) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    }

    if (state is PokemonCardPageReceivedState) {
      return Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) =>
                _pokemonCardTile(state.cards[index], context),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 15,
                ),
            itemCount: state.cards.length),
      );
    }

    return Center(
      child: Text("Erreur fatale"),
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
