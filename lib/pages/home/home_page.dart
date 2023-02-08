import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/api/model/pokemon.dart';
import 'package:pokemon/repository/pokemon_repository.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<ButtonSegment<String>> _getPokemonSegments(List<Pokemon> pokemonList) {
    return pokemonList
        .map((e) => ButtonSegment(
              value: e.name,
              label: Text(e.name),
              enabled: true,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        pokemonRepository: context.read<PokemonRepository>(),
      )..add(HomeLoadScreenEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Pokemon'),
            ),
            body: state.pokemonList.isEmpty
                ? const CircularProgressIndicator()
                : SegmentedButton(
                    segments: _getPokemonSegments(state.pokemonList),
                    selected: state.selected,
                  ),
          );
        },
      ),
    );
  }
}
