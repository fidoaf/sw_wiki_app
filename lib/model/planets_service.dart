import 'dart:convert';

class Planet {
  int id;
  String name;
  String? climate;
  String? terrain;

  Planet({
    required this.id,
    required this.name,
    required this.climate,
    required this.terrain,
  });
  factory Planet.fromJson(Map<String, dynamic> json) =>
      PlanetService._itemFromJson(json);
}

class PlanetService {
  static List<Planet> _data = <Planet>[];
  static Planet _itemFromJson(Map<String, dynamic> json) {
    return Planet(
      id: json['id'],
      name: json['name'],
      climate: json['climate'],
      terrain: json['terrain'],
    );
  }

  static void itemsFromJson(String jsonStr) => _data =
      List<Planet>.from(json.decode(jsonStr).map((x) => Planet.fromJson(x)));

  static List<Planet> get list => _data;

  static Planet? find(int id) {
    for (Planet planet in _data) {
      if (planet.id == id) return planet;
    }
    return null;
  }
}
