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
    final loadingImage = Image.asset(
      'assets/images/pokeball.gif',
      width: Constants.imageSize,
      height: Constants.imageSize,
    );

    final loadingView = Scaffold(
        body: Center(
      child: loadingImage,
    ));

    return BlocProvider(
      create: (context) => HomeBloc(
        pokemonRepository: context.read<PokemonRepository>(),
      )..add(HomeLoadScreenEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isError) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Text('Algo salió mal, revisar conexión a internet y reintenter'),
                      ElevatedButton(
                        onPressed: () => context.read<HomeBloc>().add(HomeLoadScreenEvent()),
                        child: const Text('reintentar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state.selected.isEmpty) {
            return loadingView;
          }
          final pokemon = state.pokemonMap[state.selected.first];
          return pokemon == null
              ? loadingView
              : RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(
                        const Duration(milliseconds: 500), () => context.read<HomeBloc>().add(HomeLoadScreenEvent()));
                  },
                  child: Scaffold(
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(state.selected.first.toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                            const SizedBox(height: Constants.spaceBetween),
                            SegmentedButton(
                              segments: _getPokemonSegments(state.pokemonList),
                              selected: state.selected,
                              onSelectionChanged: (value) {
                                context.read<HomeBloc>().add(HomeLoadPokemonEvent(name: value.first));
                              },
                            ),
                            const SizedBox(height: Constants.spaceBetween),
                            state.isLoading
                                ? loadingView
                                : Column(
                                    children: [
                                      const Text('HABILIDADES', style: TextStyle(fontWeight: FontWeight.bold)),
                                      GridView.count(
                                        physics: const NeverScrollableScrollPhysics(),
                                        childAspectRatio: (2),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        crossAxisCount: 3,
                                        children: Constants.skills
                                            .map((skill) => Center(
                                                  child: pokemon.skills.contains(skill)
                                                      ? ElevatedButton(
                                                          onPressed: () => context.read<HomeBloc>().add(
                                                              HomeAddRemoveSkillEvent(
                                                                  pokemon: pokemon.name, skill: skill)),
                                                          child: Text(skill.name),
                                                        )
                                                      : OutlinedButton(
                                                          onPressed: () => context.read<HomeBloc>().add(
                                                              HomeAddRemoveSkillEvent(
                                                                  pokemon: pokemon.name, skill: skill)),
                                                          child: Text(
                                                            skill.name,
                                                            style: const TextStyle(color: Colors.grey),
                                                          ),
                                                        ),
                                                ))
                                            .toList(),
                                      ),
                                      const SizedBox(height: Constants.spaceBetween),
                                      SvgPicture.network(
                                        pokemon.sprites.other.dreamWorld.front,
                                        width: Constants.imageSize,
                                        height: Constants.imageSize,
                                        fit: BoxFit.fitWidth,
                                        //placeholderBuilder: (context) => const Icon(Icons.sports_baseball, size: 200, color: Colors.red,),
                                        placeholderBuilder: (context) => loadingImage,
                                      ),
                                      const SizedBox(height: Constants.spaceBetween),
                                      Container(width: double.infinity, height: 2, color: Colors.black26),
                                      const SizedBox(height: Constants.spaceBetween),
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
                                      const SizedBox(height: Constants.spaceBetween),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
