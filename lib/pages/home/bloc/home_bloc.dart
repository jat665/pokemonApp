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
    final request = PokemonRequest(name: event.name);
    final response = await pokemonRepository.getPokemon(request: request);
    emit(state.copyWith(
      selected: {response.name},
      pokemon: response,
    ));
  }

  addRemoveSkill(HomeAddRemoveSkillEvent event, emit) async {
    final stats = _getStats(event.skill);
    final skills = _getSkills(event.skill);
    final pokemon = PokemonResponse(
      name: state.pokemon!.name,
      stats: stats,
      skills: skills,
      sprites: state.pokemon!.sprites,
    );
    emit(state.copyWith(pokemon: pokemon));
  }

  _getStats(Skill skill) {
    if (!state.pokemon!.skills.contains(skill)) {
      return state.pokemon!.getStatsAdding(skill);
    }
    return state.pokemon!.getStatsRemoving(skill);
  }

  _getSkills(Skill skill) {
    if (!state.pokemon!.skills.contains(skill)) {
      return state.pokemon!.getSkillAdding(skill);
    }
    return state.pokemon!.getSkillRemoving(skill);
  }
}
