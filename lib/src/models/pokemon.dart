import 'package:pokedex/src/models/pokemon_sprites.dart';

class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final PokemonSprites pokemonSprites;

  Pokemon({this.id, this.name, this.height, this.weight, this.pokemonSprites});

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = _capitalize(json['name']),
        height = json['height'],
        weight = json['weight'],
        pokemonSprites = json['sprites'] != null
            ? PokemonSprites.fromJson(json['sprites'])
            : null;

  @override
  String toString() {
    return 'Pokemon{id: $id, name: $name, height: $height, weight: $weight}';
  }

  static String _capitalize(String word) {
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }
}
