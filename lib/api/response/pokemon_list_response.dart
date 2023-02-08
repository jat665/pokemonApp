import 'package:pokemon/api/model/pokemon.dart';

class PokemonListResponse {
  final int count;
  final List<Pokemon> results;

  PokemonListResponse({
    required this.count,
    required this.results,
  });

  static PokemonListResponse fromMap(Map<String, dynamic> map) {
    final count = map['count'];
    final results = _getResults(map['results']);
    return PokemonListResponse(count: count, results: results);
  }

  static List<Pokemon> _getResults(List list) {
    final List<Pokemon> results = [];
    for (final item in list) {
      results.add(Pokemon.fromMap(item));
    }
    return results;
  }
}
