import '../api/request/pokemon_list_request.dart';
import '../api/response/pokemon_list_response.dart';

abstract class PokemonRepository {
  Future<PokemonListResponse> getPokemonList({required PokemonListRequest request});
}
