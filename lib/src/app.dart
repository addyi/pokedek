import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/counter_screen.dart';
import 'package:pokedex/src/screens/pmdetails/pokemon_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: CounterScreen(title: 'Flutter Demo Home Page'),
      home: PokemonScreen(),
    );
  }
}
