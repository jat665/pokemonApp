import 'package:dio/dio.dart';

import 'package:pokemon/api/request/pokemon_list_request.dart';
import 'package:pokemon/api/request/pokemon_request.dart';
import 'package:pokemon/api/response/pokemon_list_response.dart';
import 'package:pokemon/api/response/pokemon_response.dart';
import 'package:pokemon/constants.dart';

class Api {
  final Dio dio;

  Api({required this.dio});

  Future<PokemonListResponse> getPokemonList({required PokemonListRequest request}) async {
    final params = {'limit': request.limit, 'offset': request.offset};
    final response = await dio.get(Endpoint.pokemon, queryParameters: params);
    return PokemonListResponse.fromMap(response.data);
  }

  Future<PokemonResponse> getPokemon({required PokemonRequest request}) async {
    final response = await dio.get('${Endpoint.pokemon}/${request.name}');
    return PokemonResponse.fromMap(response.data);
  }
}
