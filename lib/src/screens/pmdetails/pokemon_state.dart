import 'package:meta/meta.dart';

@immutable
class PokemonState {
  final int id;

  PokemonState._(this.id);

  factory PokemonState.initial() => PokemonState._(0);
}
