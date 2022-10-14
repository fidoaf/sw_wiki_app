import 'dart:convert';

class Vehicle {
  int id;
  String name;
  String? model;

  Vehicle({
    required this.id,
    required this.name,
    required this.model,
  });
  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      VehicleService._itemFromJson(json);
}

class VehicleService {
  static List<Vehicle> _data = <Vehicle>[];
  static Vehicle _itemFromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      model: json['model'],
    );
  }

  static void itemsFromJson(String jsonStr) => _data =
      List<Vehicle>.from(json.decode(jsonStr).map((x) => Vehicle.fromJson(x)));

  static List<Vehicle> get list => _data;

  static List<Vehicle> findAll(List<int> ids) {
    List<Vehicle> vehicles = <Vehicle>[];
    for (Vehicle vehicle in _data) {
      if (ids.contains(vehicle.id)) {
        vehicles.add(vehicle);
      }
    }
    return vehicles;
  }
}
