import 'dart:convert';

import 'package:sw_app/model/films_service.dart';
import 'package:sw_app/model/planets_service.dart';
import 'package:sw_app/model/starships_service.dart';
import 'package:sw_app/model/vehicles_service.dart';

class Character {
  int id;
  String name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthyear;
  String? gender;
  String? wiki;
  String? image;

  //
  int? homeId;
  Planet? homeworld;
  List<int> filmIds;
  List<Film>? films;
  List<int> vehicleIds;
  List<Vehicle>? vehicles;
  List<int> shipIds;
  List<Starship>? starships;
  //
  List<String> affiliations;

  Character({
    required this.id,
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthyear,
    required this.gender,
    required this.wiki,
    required this.image,
    required this.affiliations,
    required this.homeId,
    required this.filmIds,
    required this.vehicleIds,
    required this.shipIds,
  });
  factory Character.fromJson(Map<String, dynamic> json) =>
      CharacterService._itemFromJson(json);
}

class CharacterService {
  static List<Character> data = <Character>[];
  static Character _itemFromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      birthyear: json['birth_year'],
      gender: json['gender'],
      wiki: json['wiki'],
      image: json['image'],
      affiliations: json['affiliations'] == null
          ? <String>[]
          : List<String>.from(json['affiliations']),
      homeId: json['homeworld'],
      filmIds: json['films'] == null ? <int>[] : List<int>.from(json['films']),
      vehicleIds:
          json['vehicles'] == null ? <int>[] : List<int>.from(json['vehicles']),
      shipIds: json['starships'] == null
          ? <int>[]
          : List<int>.from(json['starships']),
    );
  }

  static void itemsFromJson(String jsonStr) => data = List<Character>.from(
      json.decode(jsonStr).map((x) => Character.fromJson(x)));

  static List<Character> get list => data;
}
