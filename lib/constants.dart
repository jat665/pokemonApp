import 'package:pokemon/api/model/skill.dart';

class Constants {
  static const pokemonLimit = 3;
  static const imageSize = 200.0;
  static const labelWidth = 70.0;
  static const spaceBetween = 40.0;
  static const maxStatValue = 255.0;
  static const maxSkills = 2;
  static const skills = [
    Skill(name: 'Intimidación', hp: -5, attack: 10, defence: -10, speed: 15),
    Skill(name: 'Inmunidad', hp: 10, attack: -20, defence: 20, speed: -10),
    Skill(name: 'Potencia', hp: -20, attack: 15, defence: -10, speed: 15),
    Skill(name: 'Regeneración', hp: 10, attack: -20, defence: -5, speed: 5),
    Skill(name: 'Impasible', hp: -10, attack: -3, defence: -10, speed: 30),
    Skill(name: 'Tóxico', hp: -15, attack: 0, defence: -20, speed: -3),
  ];
}

class Config {
  static const baseUrl = 'https://pokeapi.co/';
  static const api = 'api/v2/';
}

class Endpoint {
  static const pokemon = 'pokemon';
}
