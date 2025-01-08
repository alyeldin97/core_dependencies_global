import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService extends StatefulWidget {
  final Function(File?) onImagePicked;

  // final String buttonText;
  final Widget? buttonText;
  final Widget? buttonGalleryText;

  const ImagePickerService({
    super.key,
    required this.onImagePicked,
    this.buttonText,
    this.buttonGalleryText,
  });

  @override
  _ImagePickerServiceState createState() => _ImagePickerServiceState();
}

class _ImagePickerServiceState extends State<ImagePickerService> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImagePicked(_selectedImage);
    } else {
      widget.onImagePicked(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selectedImage != null)
          Image.file(
            _selectedImage!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: widget.buttonText ?? Text("Take a Photo"),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: widget.buttonGalleryText ?? Text("Choose from Gallery"),
            ),
          ],
        ),
      ],
    );
  }
}
