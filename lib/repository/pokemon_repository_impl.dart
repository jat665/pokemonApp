import 'package:pokemon/repository/pokemon_repository.dart';

import '../api/api.dart';
import '../api/request/pokemon_list_request.dart';
import '../api/response/pokemon_list_response.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final Api api;

  PokemonRepositoryImpl({required this.api});

  @override
  Future<PokemonListResponse> getPokemonList({required PokemonListRequest request}) async {
    return api.getPokemonList(request: request);
  }
}
