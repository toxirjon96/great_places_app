import 'package:favourite_places_app/src/constants/id_generator.dart';

class PlacesModel {
  final String id;
  final String name;

  PlacesModel({
    required this.name,
  }) : id = IdGenerator.uid.v4();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlacesModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'PlacesModel{id: $id, name: $name}';
  }
}
