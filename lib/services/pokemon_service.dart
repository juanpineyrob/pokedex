import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

class PokeApiService {
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  Future<List<Pokemon>> fetchFirstGenerationPokemon() async {
    final List<Pokemon> pokemonList = [];

    for (int i = 1; i <= 151; i++) {
      try {
        final pokemon = await fetchPokemon(i.toString());
        pokemonList.add(pokemon);
      } catch (e) {
        print("Error al obtener el Pokémon con ID $i: $e");
      }
    }

    return pokemonList;
  }

  Future<Pokemon> fetchPokemon(String pokemonName) async {
    final response = await http.get(Uri.parse('$_baseUrl$pokemonName'));

    if (response.statusCode == 200) {
      return _parsePokemonData(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el Pokémon');
    }
  }

  Pokemon _parsePokemonData(Map<String, dynamic> data) {
    final name = data['name'];
    final number = data['id'];
    final imageUrl =
        data['sprites']['other']['official-artwork']['front_default'];
    final types = (data['types'] as List)
        .map((type) => type['type']['name'].toString())
        .toList();
    final abilities = (data['abilities'] as List)
        .map((ability) => ability['ability']['name'].toString())
        .toList();
    final stats = (data['stats'] as List)
        .map((stat) => Stat(
              stat: StatDetail(name: stat['stat']['name']),
              baseStat: stat['base_stat'],
            ))
        .toList();

    return Pokemon(
      name: name,
      number: number,
      imageUrl: imageUrl,
      types: types,
      abilities: abilities,
      stats: stats,
    );
  }
}
