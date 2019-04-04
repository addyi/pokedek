import 'package:meta/meta.dart';
import 'package:pokedex/src/models/pokemon.dart';

abstract class PokemonState {}

class PokemonEmpty extends PokemonState {}

class PokemonLoading extends PokemonState {}

@immutable
class PokemonError extends PokemonState {
  final String error;

  PokemonError(this.error);

  @override
  String toString() {
    return 'PokemonError{error: $error}';
  }
}

@immutable
class PokemonLoaded extends PokemonState {
  final Pokemon pokemon;

  PokemonLoaded(this.pokemon);

  @override
  String toString() {
    return 'PokemonLoaded{pokemon: $pokemon}';
  }
}
