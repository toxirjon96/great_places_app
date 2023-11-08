import 'package:favourite_places_app/src/app_library.dart';

class PlacesModel {
  final String id;
  final String name;
  final File image;

  PlacesModel({
    required this.name,
    required this.image,
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
