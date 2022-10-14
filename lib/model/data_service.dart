import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sw_app/model/films_service.dart';
import 'package:sw_app/model/people_service.dart';
import 'package:sw_app/model/planets_service.dart';
import 'package:sw_app/model/species_service.dart';
import 'package:sw_app/model/starships_service.dart';
import 'package:sw_app/model/vehicles_service.dart';

class DataService {
  final Map<String, Function?> _dataAssets = {
    'people': CharacterService.itemsFromJson,
    'films': FilmService.itemsFromJson,
    'planets': PlanetService.itemsFromJson,
    'species': SpecieService.itemsFromJson,
    'starships': StarshipService.itemsFromJson,
    'vehicles': VehicleService.itemsFromJson,
  };

  static final List<String> benevolentGroups = [
    "Alliance to Restore the Republic",
    "Red Squadron",
    "Rogue Squadron",
    "Massassi Group",
    "Leia Organa's team",
    "Endor strike team",
    "Jedi Order",
    "Bright Tree tribe",
    "New Republic",
    "Resistance"
  ];
  static final List<String> darkGroups = [
    "501st Legion",
    "Sith",
  ];

  static const bool _addpause = true;

  int _numLoadedAssets = 0;

  //
  // Singleton pattern
  //
  static final DataService _singleton = DataService._internal();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();
  //

  bool get complete => _numLoadedAssets == _dataAssets.length;
  double get ratio => _numLoadedAssets / _dataAssets.length;
  String get currentAsset => _getAssetName(_numLoadedAssets);

  String _getAssetName(int index) {
    List<String> keys = _dataAssets.keys.toList();
    return keys[index];
  }

  Function? _getAssetSerializer(int index) {
    List<Function?> funcs = _dataAssets.values.toList();
    return funcs[index];
  }

  static String getAssetPath(String name) {
    return 'assets/data/$name.json';
  }

  Future<int?> loadNextAsset(BuildContext context) async {
    int? next;
    try {
      if (_numLoadedAssets < _dataAssets.length) {
        String assetName = _getAssetName(_numLoadedAssets);
        String path = getAssetPath(assetName);
        if (kDebugMode) print('Loading file $path');
        String data = await DefaultAssetBundle.of(context).loadString(path);
        // Process and store data
        Function? serializer = _getAssetSerializer(_numLoadedAssets);
        if (serializer != null) serializer(data);
        // Go to the next step
        _numLoadedAssets++;
        next = _numLoadedAssets;
      }
    } catch (error) {
      if (kDebugMode) print(error);
    }
    //
    if (DataService._addpause) {
      await Future.delayed(const Duration(milliseconds: 250));
    }

    return next;
  }

  static Future<List<Character>> filterPeopleBySide(bool isDark) async {
    List<Character> filteredData = <Character>[];
    for (Character person in CharacterService.list) {
      if (person.affiliations.any((String affiliation) =>
          (isDark ? darkGroups : benevolentGroups).contains(affiliation))) {
        filteredData.add(person);
      }
    }

    //
    if (DataService._addpause) {
      await Future.delayed(const Duration(seconds: 1));
    }

    return filteredData;
  }

  static Future<Character> getFullCharacterData(Character character) async {
    if (character.homeId != null) {
      character.homeworld = PlanetService.find(character.homeId ?? 0);
    }

    if (character.filmIds.isNotEmpty) {
      character.films = FilmService.findAll(character.filmIds);
    }

    if (character.vehicleIds.isNotEmpty) {
      character.vehicles = VehicleService.findAll(character.vehicleIds);
    }

    if (character.shipIds.isNotEmpty) {
      character.starships = StarshipService.findAll(character.shipIds);
    }

    return character;
  }
}
