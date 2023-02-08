import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:pokemon/api/request/pokemon_list_request.dart';
import 'package:pokemon/constants.dart';

import 'package:pokemon/repository/pokemon_repository.dart';

import '../../../api/model/pokemon.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PokemonRepository pokemonRepository;

  HomeBloc({
    required this.pokemonRepository,
  }) : super(const HomeState.initial()) {
    on<HomeLoadScreenEvent>(loadScreen);
  }

  loadScreen(HomeLoadScreenEvent event, emit) async {
    final request = PokemonListRequest(limit: Config.pokemonLimit, offset: state.offset);
    final response = await pokemonRepository.getPokemonList(request: request);
    emit(state.copyWith(
      pokemonList: response.results,
      selected: {response.results.first.name},
      offset: state.offset + Config.pokemonLimit,
    ));
  }
}
