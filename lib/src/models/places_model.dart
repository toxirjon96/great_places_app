import 'package:favourite_places_app/src/app_library.dart';

class PlacesModel {
  final String id;
  final String name;
  final File image;
  final PlaceLocation location;

  PlacesModel({
    required this.name,
    required this.image,
    required this.location,
  }) : id = IdGenerator.uid.v4();


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlacesModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image &&
          location == other.location;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ image.hashCode ^ location.hashCode;

  @override
  String toString() {
    return 'PlacesModel{id: $id, name: $name, image: $image, location: $location}';
  }
}
