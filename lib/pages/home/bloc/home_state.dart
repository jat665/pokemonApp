part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final int offset;
  final List<Pokemon> pokemonList;
  final Set<String> selected;
  final Map<String, PokemonResponse> pokemonMap;
  final bool loading;

  const HomeState({
    required this.offset,
    required this.pokemonList,
    required this.selected,
    required this.pokemonMap,
    required this.loading,
  });

  const HomeState.initial({
    this.offset = 0,
    this.pokemonList = const [],
    this.selected = const {},
    this.pokemonMap = const {},
    this.loading = true,
  });

  HomeState copyWith({
    int? offset,
    List<Pokemon>? pokemonList,
    Set<String>? selected,
    Map<String, PokemonResponse>? pokemonMap,
    bool? loading,
  }) {
    return HomeState(
      offset: offset ?? this.offset,
      pokemonList: pokemonList ?? this.pokemonList,
      selected: selected ?? this.selected,
      pokemonMap: pokemonMap ?? this.pokemonMap,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        offset,
        pokemonList,
        selected,
        pokemonMap,
        loading,
      ];
}
