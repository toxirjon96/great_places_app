import 'dart:convert';

import 'package:favourite_places_app/src/app_library.dart';
import 'package:http/http.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
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
    final long = locationData.longitude;
    final lat = locationData.latitude;

    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyAMUS_eH_E0_qPzIuweJL_NWuRKoI8lj0w");
    final response = await get(url);
    print(response);
    if (response.statusCode>= 200 && response.statusCode < 300){
      final resData = jsonDecode(response.body);
      final formattedAddress = resData["results"][0]['formatted_address'];
      print(formattedAddress);
    }
    
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
