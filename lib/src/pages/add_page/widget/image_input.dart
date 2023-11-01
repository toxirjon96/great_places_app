import 'package:favourite_places_app/src/app_library.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    required this.onPickImage,
    super.key,
  });

  final void Function(File file) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImageFile;

  void _takePicture() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      _selectedImageFile = File(image.path);
    } else {
      return;
    }
    widget.onPickImage(_selectedImageFile!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: _selectedImageFile != null
          ? Center(
              child: Image.file(
                _selectedImageFile!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          : TextButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text("Take a picture"),
            ),
    );
  }
}
