import 'package:meta/meta.dart';
import 'package:pokedex/src/models/pokemon.dart';

abstract class PokemonState {}

class PokemonEmpty extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonError extends PokemonState {}

@immutable
class PokemonLoaded extends PokemonState {
  final Pokemon pokemon;

  PokemonLoaded._(this.pokemon);

  factory PokemonLoaded.newPokemon(pokemon) => PokemonLoaded._(pokemon);

  @override
  String toString() {
    return 'PokemonLoaded{pokemon: $pokemon}';
  }
}
