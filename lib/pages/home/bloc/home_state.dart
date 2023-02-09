part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final int offset;
  final List<Pokemon> pokemonList;
  final Set<String> selected;
  final Map<String, PokemonResponse> pokemonMap;

  const HomeState({
    required this.offset,
    required this.pokemonList,
    required this.selected,
    required this.pokemonMap,
  });

  const HomeState.initial({
    this.offset = 0,
    this.pokemonList = const [],
    this.selected = const {},
    this.pokemonMap = const {},
  });

  HomeState copyWith({
    int? offset,
    List<Pokemon>? pokemonList,
    Set<String>? selected,
    Map<String, PokemonResponse>? pokemonMap,
  }) {
    return HomeState(
      offset: offset ?? this.offset,
      pokemonList: pokemonList ?? this.pokemonList,
      selected: selected ?? this.selected,
      pokemonMap: pokemonMap ?? this.pokemonMap,
    );
  }

  @override
  List<Object?> get props => [
        offset,
        pokemonList,
        selected,
        pokemonMap,
      ];
}
