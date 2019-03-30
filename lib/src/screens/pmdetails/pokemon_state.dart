import 'package:meta/meta.dart';

@immutable
class PokemonState {
  final int id;
  final Map<String, dynamic> json;

  PokemonState._(this.id, this.json);

  factory PokemonState.initial() => PokemonState._(0, null);

  factory PokemonState.newPokemon(id, json) => PokemonState._(id, json);

  @override
  String toString() {
    return 'PokemonState: $id';
  }
}
