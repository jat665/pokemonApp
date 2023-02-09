import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:pokemon/api/model/skill.dart';
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
    on<HomeAddRemoveSkillEvent>(addRemoveSkill);
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
    if (!state.pokemonMap.containsKey(event.name)) {
      final request = PokemonRequest(name: event.name);
      final response = await pokemonRepository.getPokemon(request: request);
      return emit(state.copyWith(
        selected: {response.name},
        pokemonMap: _getPokemonMapReplacing(response),
      ));
    }
    return emit(state.copyWith(
      selected: {event.name},
    ));
  }

  addRemoveSkill(HomeAddRemoveSkillEvent event, emit) async {
    final stats = _getStats(event);
    final skills = _getSkills(event);
    final pokemon = PokemonResponse(
      name: state.pokemonMap[event.pokemon]!.name,
      stats: stats,
      skills: skills,
      sprites: state.pokemonMap[event.pokemon]!.sprites,
    );
    emit(state.copyWith(pokemonMap: _getPokemonMapReplacing(pokemon)));
  }

  Map<String, PokemonResponse> _getPokemonMapReplacing(PokemonResponse pokemon) {
    Map<String, PokemonResponse> pokemonMap = {};
    pokemonMap[pokemon.name] = pokemon;
    for (String key in state.pokemonMap.keys) {
      if (key != pokemon.name) {
        pokemonMap[key] = state.pokemonMap[key]!;
      }
    }
    return pokemonMap;
  }

  _getStats(HomeAddRemoveSkillEvent event) {
    final pokemon = state.pokemonMap[event.pokemon];
    if (!pokemon!.skills.contains(event.skill)) {
      return pokemon.getStatsAdding(event.skill);
    }
    return pokemon.getStatsRemoving(event.skill);
  }

  _getSkills(HomeAddRemoveSkillEvent event) {
    final pokemon = state.pokemonMap[event.pokemon];
    if (!pokemon!.skills.contains(event.skill)) {
      return pokemon.getSkillAdding(event.skill);
    }
    return pokemon.getSkillRemoving(event.skill);
  }
}
