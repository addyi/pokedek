import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/pmdetails/pokemon_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/screens/pmdetails/pokemon_state.dart';

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final PokemonBloc _pokemonBloc = PokemonBloc();

  @override
  void initState() {
    super.initState();
    _pokemonBloc.onFetchPokemon(); // correct position for fetch?
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [BlocProvider<PokemonBloc>(bloc: _pokemonBloc)],
      child: PokemonDetailsScaffold(),
    );
  }

  @override
  void dispose() {
    _pokemonBloc.dispose();
    super.dispose();
  }
}

class PokemonDetailsScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PokemonBloc _pokemonBloc = BlocProvider.of<PokemonBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Pokemon Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder(
          bloc: _pokemonBloc,
          builder: (_, PokemonState state) {
            if (state is PokemonEmpty) {
              _pokemonBloc.onFetchPokemon();
              return PokemonErrorWidget();
            } else if (state is PokemonLoading) {
              return PokemonLoadingWidget();
            } else if (state is PokemonLoaded) {
              return PokemonStatistics();
            } else if (state is PokemonError) {
              return PokemonErrorWidget();
            } else {
              // TODO: ILLEGAL STATE EXCEPTION
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('refresh_fab'),
        onPressed: () => _pokemonBloc.onFetchPokemon(),
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              key: Key('menu_iconButton'),
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => Navigator.of(context).pushNamed('/count'),
            ),
          ],
        ),
      ),
    );
  }
}

class PokemonErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '¯\\_(ツ)_/¯',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 15),
          Text(
            "We unfortunately experienced technical difficulties please try again.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PokemonLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Loading"),
        ],
      ),
    );
  }
}

class PokemonStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PokemonBloc _pokemonBloc = BlocProvider.of<PokemonBloc>(context);

    return BlocBuilder(
      bloc: _pokemonBloc,
      builder: (_, PokemonState state) {
        if (state is PokemonLoaded) {
          return RefreshIndicator(
            onRefresh: () {
              _pokemonBloc.onFetchPokemon();
            },
            child: ListView(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Image.network(state.pokemon.pokemonSprites.frontDefault),
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/pokemon-0.png',
                        image: state.pokemon.pokemonSprites.frontDefault,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${state.pokemon.name} #${state.pokemon.id}',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Height: ${state.pokemon.height}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Weight: ${state.pokemon.weight}',
                          style: TextStyle(fontSize: 16),
                        ),
                        //Text('${state.pokemon.toString()}'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // TODO: _pokemonBloc.onException() [not onError!!]
        }
      },
    );
  }
}
