import 'package:favourite_places_app/src/app_library.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    required this.onChooseLocation,
    super.key,
  });

  final void Function(PlaceLocation location) onChooseLocation;

  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool _isGettingLocation = false;
  PlaceLocation? _locationModel;

  String get locationImage {
    if (_locationModel == null) {
      return '';
    }

    final long = _locationModel!.longitude;
    final lat = _locationModel!.latitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=AIzaSyAMUS_eH_E0_qPzIuweJL_NWuRKoI8lj0w";
  }

  Future<void> _selectOnMap() async {
    final position = await Navigator.of(context).push<LatLng?>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );
    if (position == null) return;
    _savePlace(
      position.latitude,
      position.longitude,
    );
  }

  void _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAMUS_eH_E0_qPzIuweJL_NWuRKoI8lj0w");
    final response = await get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final resData = jsonDecode(response.body);
      final formattedAddress = resData["results"][0]['formatted_address'];
      setState(() {
        _locationModel = PlaceLocation(
          longitude: longitude,
          latitude: latitude,
          address: formattedAddress,
        );
        _isGettingLocation = false;
      });
      widget.onChooseLocation(_locationModel!);
    } else {
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final long = locationData.longitude;
    final lat = locationData.latitude;

    if (long == null || lat == null) return;
    _savePlace(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      "No location choosen!",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
    if (_locationModel != null) {
      content = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (_isGettingLocation) {
      content = Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: content,
        ),
        Row(
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get Current Location"),
            ),
            const SizedBox(width: 10),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text("Choose location"),
            ),
          ],
        )
      ],
    );
  }
}
