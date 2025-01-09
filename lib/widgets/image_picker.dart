import 'dart:io';
import 'package:core_dependencies_global/core_dependencies_global.dart';
import 'package:core_dependencies_global/dependency_injection/dependency_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showPickImageModalSheet(context, Function(File?) onImagePicked,
    {TextStyle? buttonTextStyle}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => _ImagePickerMenu(
      onImagePicked: onImagePicked,
      buttonTextStyle: buttonTextStyle,
    ),
  );
}

class _ImagePickerMenu extends StatelessWidget {
  final Function(File?) onImagePicked;
  final TextStyle? buttonTextStyle;

  const _ImagePickerMenu({
    required this.onImagePicked,
    this.buttonTextStyle,
  });

  Future<void> _pickImageFromGallery() async => onImagePicked(
      await DependencyInjector().imagePickerService.pickImageFromGallery());

  Future<void> _pickImageFromCamera() async => onImagePicked(
      await DependencyInjector().imagePickerService.pickImageFromCamera());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImageFromCamera(),
          icon: const Icon(Icons.camera_alt),
          label: Text(
            "Take a Photo",
            style: buttonTextStyle ?? TextStyle(fontSize: 12.sp),
          ),
        ),
        10.widthBox___________________________(),
        ElevatedButton.icon(
          onPressed: () => _pickImageFromGallery(),
          icon: const Icon(Icons.photo),
          label: Text("Choose from Gallery",
              style: buttonTextStyle ?? TextStyle(fontSize: 12.sp)),
        ),
      ],
    );
  }
}
