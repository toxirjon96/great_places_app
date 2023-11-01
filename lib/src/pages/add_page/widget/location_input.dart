import 'package:favourite_places_app/src/app_library.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    required this.onCurrentLocation,
    super.key,
  });

  final void Function(LocationData locationData) onCurrentLocation;

  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation;
  bool _isGettingLocation = false;

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
    setState(() {
      _isGettingLocation = false;
    });
    print("${locationData.latitude},${locationData.latitude}");
    widget.onCurrentLocation(locationData);
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
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text("Choose location"),
            ),
          ],
        )
      ],
    );
  }
}
