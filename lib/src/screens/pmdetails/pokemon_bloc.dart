import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:pokedex/src/models/pokemon.dart';
import 'package:pokedex/src/screens/pmdetails/pokemon_events.dart';
import 'package:pokedex/src/screens/pmdetails/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  @override
  PokemonState get initialState => PokemonEmpty();

  final Random _random = Random();

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is FetchPokemonEvent) {
      yield PokemonLoading();
      yield await _fetchPokemon();
    }
  }

  Future<PokemonState> _fetchPokemon() async {
    try {
      int rand = _random.nextInt(806) + 1; // min 1, max 807
      var response = await get('https://pokeapi.co/api/v2/pokemon/$rand/');
      if (response.statusCode == 200) {
        Pokemon pokemon = Pokemon.fromJson(jsonDecode(response.body));
        return PokemonLoaded.newPokemon(pokemon);
      } else {
        // TODO: CHECK CASE
      }
      return null;
    } catch (_) {
      return PokemonError();
    }
  }

  void onFetchPokemon() => dispatch(FetchPokemonEvent());
}
