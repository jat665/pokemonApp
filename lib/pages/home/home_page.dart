import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon/api/model/pokemon.dart';
import 'package:pokemon/api/model/stat.dart';
import 'package:pokemon/constants.dart';
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
          if (state.selected.isEmpty) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          final pokemon = state.pokemonMap[state.selected.first];
          return pokemon == null
              ? const Scaffold(body: Center(child: CircularProgressIndicator()))
              : Scaffold(
                  appBar: AppBar(
                    title: Text(pokemon.name),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SegmentedButton(
                          segments: _getPokemonSegments(state.pokemonList),
                          selected: state.selected,
                          onSelectionChanged: (value) {
                            context.read<HomeBloc>().add(HomeLoadPokemonEvent(name: value.first));
                          },
                        ),
                        const SizedBox(height: Constants.spaceBetween),
                        const Text('HABILIDADES', style: TextStyle(fontWeight: FontWeight.bold)),
                        GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemCount: Constants.skills.length,
                          itemBuilder: (context, int index) => Center(
                              child: pokemon.skills.contains(Constants.skills[index])
                                  ? ElevatedButton(
                                      onPressed: () => context.read<HomeBloc>().add(HomeAddRemoveSkillEvent(
                                          pokemon: pokemon.name, skill: Constants.skills[index])),
                                      child: Text(Constants.skills[index].name),
                                    )
                                  : OutlinedButton(
                                      onPressed: () => context.read<HomeBloc>().add(HomeAddRemoveSkillEvent(
                                          pokemon: pokemon.name, skill: Constants.skills[index])),
                                      child: Text(
                                        Constants.skills[index].name,
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    )),
                        ),
                        const SizedBox(height: Constants.spaceBetween),
                        SvgPicture.network(
                          pokemon.sprites.other.dreamWorld.front,
                          width: Constants.imageSize,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(height: Constants.spaceBetween),
                        Container(width: double.infinity, height: 2, color: Colors.black26),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: Constants.labelWidth, child: Text('Vida')),
                                  Expanded(
                                    child: Slider(
                                      value: pokemon.stats[Stat.hp].baseStat.toDouble(),
                                      onChanged: (value) {},
                                      max: Constants.maxStatValue,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: Constants.labelWidth, child: Text('Ataque')),
                                  Expanded(
                                    child: Slider(
                                      value: pokemon.stats[Stat.attack].baseStat.toDouble(),
                                      onChanged: (value) {},
                                      max: Constants.maxStatValue,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: Constants.labelWidth, child: Text('Defensa')),
                                  Expanded(
                                    child: Slider(
                                      value: pokemon.stats[Stat.defence].baseStat.toDouble(),
                                      onChanged: (value) {},
                                      max: Constants.maxStatValue,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: Constants.labelWidth, child: Text('Velocidad')),
                                  Expanded(
                                    child: Slider(
                                      value: pokemon.stats[Stat.speed].baseStat.toDouble(),
                                      onChanged: (value) {},
                                      max: Constants.maxStatValue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
