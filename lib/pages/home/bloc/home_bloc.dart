import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:pokemon/api/request/pokemon_list_request.dart';
import 'package:pokemon/constants.dart';

import 'package:pokemon/repository/pokemon_repository.dart';

import '../../../api/model/pokemon.dart';
import '../../../api/request/pokemon_request.dart';
import '../../../api/response/pokemon_response.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PokemonRepository pokemonRepository;

  HomeBloc({
    required this.pokemonRepository,
  }) : super(const HomeState.initial()) {
    on<HomeLoadScreenEvent>(loadScreen);
    on<HomeLoadPokemonEvent>(loadPokemon);
  }

  loadScreen(HomeLoadScreenEvent event, emit) async {
    final request = PokemonListRequest(limit: Constants.pokemonLimit, offset: state.offset);
    final response = await pokemonRepository.getPokemonList(request: request);
    final pokemon = response.results.first.name;
    emit(state.copyWith(
      pokemonList: response.results,
      selected: {pokemon},
      offset: state.offset + Constants.pokemonLimit,
    ));
    await loadPokemon(HomeLoadPokemonEvent(name: pokemon), emit);
  }

  loadPokemon(HomeLoadPokemonEvent event, emit) async {
    final request = PokemonRequest(name: event.name);
    final response = await pokemonRepository.getPokemon(request: request);
    emit(state.copyWith(
      selected: {response.name},
      pokemon: response,
    ));
  }
}
