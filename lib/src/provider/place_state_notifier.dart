import 'package:favourite_places_app/src/app_library.dart';

class PlaceStateNotifier extends StateNotifier<List<PlacesModel>> {
  PlaceStateNotifier() : super([]);

  void addItem(PlacesModel place) {
    state = [place, ...state];
  }

  void removeItem(PlacesModel place) {
    state = state.where((item) => item.id != place.id).toList();
  }
}

final placeProvider =
    StateNotifierProvider<PlaceStateNotifier, List<PlacesModel>>(
  (ref) => PlaceStateNotifier(),
);
