part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeLoadScreenEvent extends HomeEvent {}

class HomeLoadPokemonEvent extends HomeEvent {
  final String name;

  HomeLoadPokemonEvent({required this.name});
}

class HomeAddRemoveSkillEvent extends HomeEvent {
  final Skill skill;

  HomeAddRemoveSkillEvent({required this.skill});
}
