part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final int offset;
  final List<Pokemon> pokemonList;
  final Set<String> selected;
  final PokemonResponse? pokemon;

  const HomeState({
    required this.offset,
    required this.pokemonList,
    required this.selected,
    required this.pokemon,
  });

  const HomeState.initial({
    this.offset = 0,
    this.pokemonList = const [],
    this.selected = const {},
    this.pokemon,
  });

  HomeState copyWith({
    int? offset,
    List<Pokemon>? pokemonList,
    Set<String>? selected,
    PokemonResponse? pokemon,
  }) {
    return HomeState(
      offset: offset ?? this.offset,
      pokemonList: pokemonList ?? this.pokemonList,
      selected: selected ?? this.selected,
      pokemon: pokemon,
    );
  }

  @override
  List<Object?> get props => [
        offset,
        pokemonList,
        selected,
        pokemon,
      ];
}
