import 'package:favourite_places_app/src/app_library.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    _placesFuture = ref.read(placeProvider.notifier).loadPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: _placesFuture,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: places.length,
                itemBuilder: (ctx, index) {
                  return Dismissible(
                    onDismissed: (value) {
                      ref
                          .read(placeProvider.notifier)
                          .removeItem(places[index]);
                    },
                    key: Key(places[index].id),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                SinglePlacePage(place: places[index]),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundImage: FileImage(places[index].image),
                        ),
                        subtitle: Text(
                          places[index].location.address,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                        ),
                        title: Text(
                          places[index].name,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
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
