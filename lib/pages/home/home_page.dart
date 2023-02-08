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
          final pokemon = state.pokemon;
          return pokemon == null
              ? const CircularProgressIndicator()
              : Scaffold(
                  appBar: AppBar(
                    title: Text(pokemon.name),
                  ),
                  body: Column(
                    children: [
                      SegmentedButton(
                        segments: _getPokemonSegments(state.pokemonList),
                        selected: state.selected,
                        onSelectionChanged: (value) {
                          context.read<HomeBloc>().add(HomeLoadPokemonEvent(name: value.first));
                        },
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
                );
        },
      ),
    );
  }
}
