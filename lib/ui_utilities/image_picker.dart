import 'dart:io';
 import 'package:core_dependencies_global/core_dependencies_global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerService extends StatelessWidget {
  final Function(File?) onImagePicked;


  final Widget? buttonText;
  final Widget? buttonGalleryText;

  ImagePickerService({
    super.key,
    required this.onImagePicked,
    this.buttonText,
    this.buttonGalleryText,
  });

  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      onImagePicked(_selectedImage);
    } else {
      onImagePicked(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.camera),
          icon: const Icon(Icons.camera_alt),
          label: buttonText ?? const Text("Take a Photo"),
        ),
        10.widthBox___________________________(),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.gallery),
          icon: const Icon(Icons.photo),
          label: buttonGalleryText ?? const Text("Choose from Gallery"),
        ),
      ],
    );
  }
}
