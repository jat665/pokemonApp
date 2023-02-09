part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final int offset;
  final List<Pokemon> pokemonList;
  final Set<String> selected;
  final Map<String, PokemonResponse> pokemonMap;
  final bool isLoading;
  final bool isError;

  const HomeState({
    required this.offset,
    required this.pokemonList,
    required this.selected,
    required this.pokemonMap,
    required this.isLoading,
    required this.isError,
  });

  const HomeState.initial({
    this.offset = 0,
    this.pokemonList = const [],
    this.selected = const {},
    this.pokemonMap = const {},
    this.isLoading = true,
    this.isError = false,
  });

  HomeState copyWith({
    int? offset,
    List<Pokemon>? pokemonList,
    Set<String>? selected,
    Map<String, PokemonResponse>? pokemonMap,
    bool? isLoading,
    bool? isError,
  }) {
    return HomeState(
      offset: offset ?? this.offset,
      pokemonList: pokemonList ?? this.pokemonList,
      selected: selected ?? this.selected,
      pokemonMap: pokemonMap ?? this.pokemonMap,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? false,
    );
  }

  @override
  List<Object?> get props => [
        offset,
        pokemonList,
        selected,
        pokemonMap,
        isLoading,
      ];
}
