import 'package:equatable/equatable.dart';
import 'package:pokemon/constants.dart';

import '../model/skill.dart';
import '../model/sprites.dart';
import '../model/stat.dart';

class PokemonResponse extends Equatable {
  final String name;
  final List<Stat> stats;
  final Sprites sprites;
  final List<Skill> skills;

  const PokemonResponse({
    required this.name,
    required this.stats,
    required this.sprites,
    required this.skills,
  });

  List<Stat> getStatsAdding(Skill skill) {
    List<Stat> stats = List.from(this.stats);
    if (skills.length == Constants.maxSkills) {
      return stats;
    }
    stats[Stat.hp].baseStat = stats[Stat.hp].baseStat + skill.hp;
    stats[Stat.attack].baseStat = stats[Stat.attack].baseStat + skill.attack;
    stats[Stat.defence].baseStat = stats[Stat.defence].baseStat + skill.defence;
    stats[Stat.speed].baseStat = stats[Stat.speed].baseStat + skill.speed;
    return stats;
  }

  List<Stat> getStatsRemoving(Skill skill) {
    List<Stat> stats = this.stats.toList();
    stats[Stat.hp].baseStat = stats[Stat.hp].baseStat - skill.hp;
    stats[Stat.attack].baseStat = stats[Stat.attack].baseStat - skill.attack;
    stats[Stat.defence].baseStat = stats[Stat.defence].baseStat - skill.defence;
    stats[Stat.speed].baseStat = stats[Stat.speed].baseStat - skill.speed;
    return stats;
  }

  List<Skill> getSkillAdding(Skill skill) {
    List<Skill> skills = this.skills.toList();
    if (skills.length == Constants.maxSkills) {
      return skills;
    }
    skills.add(skill);
    return skills;
  }

  List<Skill> getSkillRemoving(Skill skill) {
    List<Skill> skills = this.skills.toList();
    skills.remove(skill);
    return skills;
  }

  static PokemonResponse fromMap(Map<String, dynamic> map) {
    final stats = _getStats(map['stats']);
    return PokemonResponse(
      name: map['name'],
      stats: stats,
      sprites: Sprites.fromMap(map['sprites']),
      skills: const [],
    );
  }

  static List<Stat> _getStats(List list) {
    final List<Stat> results = [];
    for (final item in list) {
      results.add(Stat.fromMap(item));
    }
    return results;
  }

  @override
  List<Object?> get props => [
    name,
    stats,
    skills,
  ];
}
