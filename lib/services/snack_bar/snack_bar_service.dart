import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

abstract class SnackBarService {
  void showSnackBar(String message, Color? backgroundColor, Color? textColor,
      SnackPosition? position, String? title);
}

class SnackBarImpl implements SnackBarService {
  @override
  void showSnackBar(String message, Color? backgroundColor, Color? textColor,
      SnackPosition? position, String? title) {
    Get.snackbar(
      title ?? 'Success',
      message,
      snackPosition: position ?? SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.green,
      colorText: textColor ?? Colors.white,
      duration: Duration(seconds: 3),
    );
  }
}
