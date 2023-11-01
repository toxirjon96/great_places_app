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
      body: Center(
        child: Text(
          place.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
        ),
      ),
    );
  }
}
