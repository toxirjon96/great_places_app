import 'package:favourite_places_app/src/app_library.dart';

class AddItem extends ConsumerStatefulWidget {
  const AddItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {
  final TextEditingController controller = TextEditingController();

  void _saveItem() {
    String name = controller.text;

    if (name.isNotEmpty) {
      ref.read(placeProvider.notifier).addItem(
            PlacesModel(
              name: name,
            ),
          );
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text(
                  "Name",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: _saveItem,
              icon: const Icon(Icons.add),
              label: const Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}
