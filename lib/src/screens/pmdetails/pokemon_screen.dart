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
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [BlocProvider<PokemonBloc>(bloc: _pokemonBloc)],
      child: PokemonDetails(),
    );
  }

  @override
  void dispose() {
    _pokemonBloc.dispose();
    super.dispose();
  }
}

class PokemonDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PokemonBloc _pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    return BlocBuilder(
      bloc: _pokemonBloc,
      builder: (_, PokemonState state) {
        return Scaffold(
          appBar: AppBar(title: Text('Pokemon Details')),
          body: Text('Pokemon-Nr.: ${state.id}\n ${state.json}'),
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
      },
    );
  }
}
