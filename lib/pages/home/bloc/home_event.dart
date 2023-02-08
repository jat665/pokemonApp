part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeLoadScreenEvent extends HomeEvent {}

class HomeLoadPokemonEvent extends HomeEvent {
  final String name;

  HomeLoadPokemonEvent({required this.name});
}
