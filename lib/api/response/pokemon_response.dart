import '../model/sprites.dart';
import '../model/stat.dart';

class PokemonResponse {
  final String name;
  final List<Stat> stats;
  final Sprites sprites;

  PokemonResponse({
    required this.name,
    required this.stats,
    required this.sprites,
  });

  static PokemonResponse fromMap(Map<String, dynamic> map) {
    final stats = _getStats(map['stats']);
    return PokemonResponse(
      name: map['name'],
      stats: stats,
      sprites: Sprites.fromMap(map['sprites']),
    );
  }

  static List<Stat> _getStats(List list) {
    final List<Stat> results = [];
    for (final item in list) {
      results.add(Stat.fromMap(item));
    }
    return results;
  }
}
