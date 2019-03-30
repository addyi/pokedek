import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/pmdetails/pokemon_bloc.dart';

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final PokemonBloc _pokemonBloc = PokemonBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon Details')),
      body: Text('A Pokemon'),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
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
