import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokemon/pages/home/home_page.dart';
import 'package:pokemon/repository/pokemon_repository_impl.dart';
import 'api/api.dart';
import 'constants.dart';
import 'repository/pokemon_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: '${Config.baseUrl}${Config.api}'));
    dio.interceptors.add(DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ));
    final api = Api(dio: dio);

    return RepositoryProvider<PokemonRepository>(
      create: (context) => PokemonRepositoryImpl(api: api),
      child: MaterialApp(
        title: 'Pokemon App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
