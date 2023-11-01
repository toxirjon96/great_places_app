import 'package:favourite_places_app/src/app_library.dart';
import 'package:favourite_places_app/src/pages/single_place_page/single_pace_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PlacesModel> places = ref.watch(placeProvider);
    Widget content = Center(
      child: Text(
        "No items found! Try to add one!",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
      ),
    );
    if (places.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: places.length,
          itemBuilder: (ctx, index) {
            return Dismissible(
              onDismissed: (value) {
                ref.read(placeProvider.notifier).removeItem(places[index]);
              },
              key: Key(places[index].id),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => SinglePlacePage(place: places[index]),
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: FileImage(places[index].image),
                  ),
                  title: Text(
                    places[index].name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddItem(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
