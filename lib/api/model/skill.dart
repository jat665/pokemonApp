import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String name;
  final int hp;
  final int attack;
  final int defence;
  final int speed;

  const Skill({
    required this.name,
    required this.hp,
    required this.attack,
    required this.defence,
    required this.speed,
  });

  @override
  List<Object?> get props => [name];
}
