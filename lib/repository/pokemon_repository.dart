import '../api/request/pokemon_list_request.dart';
import '../api/response/pokemon_list_response.dart';
import '../api/request/pokemon_request.dart';
import '../api/response/pokemon_response.dart';

abstract class PokemonRepository {
  Future<PokemonListResponse> getPokemonList({required PokemonListRequest request});

  Future<PokemonResponse> getPokemon({required PokemonRequest request});
}
