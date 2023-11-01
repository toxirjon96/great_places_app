import 'package:favourite_places_app/src/app_library.dart';

class SinglePlacePage extends StatelessWidget {
  const SinglePlacePage({
    required this.place,
    super.key,
  });

  final PlacesModel place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
