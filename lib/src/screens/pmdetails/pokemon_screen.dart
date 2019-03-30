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
      appBar: AppBar(
        title: Text('Pokemon Details')
      ),
      body: Text('A Pokemon'),
    );
  }
}
