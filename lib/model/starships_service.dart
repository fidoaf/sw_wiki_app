import 'dart:convert';

class Starship {
  int id;
  String name;
  String? model;

  Starship({
    required this.id,
    required this.name,
    required this.model,
  });
  factory Starship.fromJson(Map<String, dynamic> json) =>
      StarshipService._itemFromJson(json);
}

class StarshipService {
  static List<Starship> _data = <Starship>[];
  static Starship _itemFromJson(Map<String, dynamic> json) {
    return Starship(
      id: json['id'],
      name: json['name'],
      model: json['model'],
    );
  }

  static void itemsFromJson(String jsonStr) => _data = List<Starship>.from(
      json.decode(jsonStr).map((x) => Starship.fromJson(x)));

  static List<Starship> get list => _data;

  static List<Starship> findAll(List<int> ids) {
    List<Starship> starships = <Starship>[];
    for (Starship ship in _data) {
      if (ids.contains(ship.id)) {
        starships.add(ship);
      }
    }
    return starships;
  }
}
