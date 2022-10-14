import 'dart:convert';

class Specie {
  int id;
  String name;
  String? classification;
  String? designation;
  String? language;

  Specie({
    required this.id,
    required this.name,
    required this.classification,
    required this.designation,
    required this.language,
  });
  factory Specie.fromJson(Map<String, dynamic> json) =>
      SpecieService._itemFromJson(json);
}

class SpecieService {
  static List<Specie> data = <Specie>[];
  static Specie _itemFromJson(Map<String, dynamic> json) {
    return Specie(
      id: json['id'],
      name: json['name'],
      classification: json['classification'],
      designation: json['designation'],
      language: json['language'],
    );
  }

  static void itemsFromJson(String jsonStr) => data =
      List<Specie>.from(json.decode(jsonStr).map((x) => Specie.fromJson(x)));

  static List<Specie> get list => data;
}
