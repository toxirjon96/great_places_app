class PlaceLocation {
  final double longitude;
  final double latitude;
  final String address;

  PlaceLocation({
    required this.longitude,
    required this.latitude,
    required this.address,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceLocation &&
          runtimeType == other.runtimeType &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          address == other.address;

  @override
  int get hashCode => longitude.hashCode ^ latitude.hashCode ^ address.hashCode;

  @override
  String toString() {
    return 'PlaceLocation{longitude: $longitude, latitude: $latitude, address: $address}';
  }
}
