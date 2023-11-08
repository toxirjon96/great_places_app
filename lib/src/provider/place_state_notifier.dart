import 'package:favourite_places_app/src/app_library.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> _getDataBase() async {
  final dbPath = await getDatabasesPath();
  final db =
      await openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
    return db.execute("CREATE TABLE user_places("
        "id TEXT PRIMARY KEY, "
        "title TEXT, "
        "image TEXT, "
        "lat REAL, "
        "lng REAL, "
        "address TEXT"
        ")");
  }, version: 1);
  return db;
}

class PlaceStateNotifier extends StateNotifier<List<PlacesModel>> {
  PlaceStateNotifier() : super([]);

  Future<void> loadPlace() async {
    final db = await _getDataBase();
    final data = await db.query('user_places');

    final places = data.map<PlacesModel>(
      (row) => PlacesModel(
        id: row['id'] as String?,
        name: row['title'] as String,
        image: File(row['image'] as String),
        location: PlaceLocation(
          longitude: row['lng'] as double,
          latitude: row['lat'] as double,
          address: row['address'] as String,
        ),
      ),
    ).toList();

    state = places;
  }

  void addItem(
    String title,
    File image,
    PlaceLocation location,
  ) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(image.path);
    final copiedImage = await image.copy("${appDir.path}/$fileName");
    PlacesModel place = PlacesModel(
      name: title,
      image: copiedImage,
      location: location,
    );
    final db = await _getDataBase();
    db.insert("user_places", {
      "id": place.id,
      'title': place.name,
      'image': place.image.path,
      'lat': place.location.latitude,
      'lng': place.location.longitude,
      'address': place.location.address,
    });
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
