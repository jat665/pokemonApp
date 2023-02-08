part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final int offset;
  final List<Pokemon> pokemonList;
  final Set<String> selected;

  const HomeState({
    required this.offset,
    required this.pokemonList,
    required this.selected,
  });

  const HomeState.initial({
    this.offset = 0,
    this.pokemonList = const [],
    this.selected = const {},
  });

  HomeState copyWith({
    int? offset,
    List<Pokemon>? pokemonList,
    Set<String>? selected,
  }) {
    return HomeState(
      offset: offset ?? this.offset,
      pokemonList: pokemonList ?? this.pokemonList,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [
        offset,
        pokemonList,
        selected,
      ];
}
