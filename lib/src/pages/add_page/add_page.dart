import 'package:favourite_places_app/src/app_library.dart';

class AddItem extends ConsumerStatefulWidget {
  const AddItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {
  final TextEditingController _controller = TextEditingController();
  File? _imageFile;
  PlaceLocation? _location;

  void _saveItem() {
    String name = _controller.text;

    if (name.isNotEmpty && _imageFile != null && _location != null) {
      ref.read(placeProvider.notifier).addItem(
            PlacesModel(
              name: name,
              image: _imageFile!,
              location: _location!,
            ),
          );
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              controller: _controller,
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
            ImageInput(
              onPickImage: (image) {
                _imageFile = image;
              },
            ),
            const SizedBox(height: 20),
            LocationInput(
              onChooseLocation: (location) {
                _location = location;
              },
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
