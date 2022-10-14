import 'dart:convert';

class Film {
  int id;
  String title;
  String? opening;
  String? director;

  Film({
    required this.id,
    required this.title,
    required this.opening,
    required this.director,
  });
  factory Film.fromJson(Map<String, dynamic> json) =>
      FilmService._itemFromJson(json);
}

class FilmService {
  static List<Film> _data = <Film>[];
  static Film _itemFromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      title: json['title'],
      opening: json['opening_crawl'],
      director: json['director'],
    );
  }

  static void itemsFromJson(String jsonStr) => _data =
      List<Film>.from(json.decode(jsonStr).map((x) => Film.fromJson(x)));

  static List<Film> get list => _data;

  static List<Film> findAll(List<int> ids) {
    List<Film> films = <Film>[];
    for (Film film in _data) {
      if (ids.contains(film.id)) {
        films.add(film);
      }
    }
    return films;
  }
}
