import 'package:meta/meta.dart';

abstract class PokemonState {}

class PokemonEmpty extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonError extends PokemonState {}

@immutable
class PokemonLoaded extends PokemonState {
  final int id;
  final Map<String, dynamic> json;

  PokemonLoaded._(this.id, this.json);

  factory PokemonLoaded.initial() => PokemonLoaded._(0, null);

  factory PokemonLoaded.newPokemon(id, json) => PokemonLoaded._(id, json);

  @override
  String toString() {
    return 'PokemonState: $id';
  }
}
