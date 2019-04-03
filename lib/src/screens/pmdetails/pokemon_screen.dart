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
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          bloc: _pokemonBloc,
          builder: (_, PokemonState state) {
            if (state is PokemonEmpty) {
              _pokemonBloc.onFetchPokemon();
              return Text('TODO PokemonEmpty'); // TODO
            } else if (state is PokemonLoading) {
              return PokemonLoading();
            } else if (state is PokemonLoaded) {
              return PokemonStatistics();
            } else if (state is PokemonError) {
              return Text('Todo PokemonError'); // TODO
            } else {
              // TODO: ILLEGAL STATE EXCEPTION
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pokemonBloc.onFetchPokemon(),
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
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

class PokemonLoading extends StatelessWidget {
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pokemon-Nr.: ${state.id}'),
              Text(
                  'Name.: ${state.json == null ? 'Is null' : state.json['name']}'),
              Text(
                  'Sprite.: ${state.json == null ? 'Is null' : state.json['sprites']}'),
              Image.network(state.json == null
                  ? ''
                  : state.json['sprites']['front_default']),
            ],
          );
        } else {
          // TODO: _pokemonBloc.onException() [not onError!!]
        }
      },
    );
  }
}
