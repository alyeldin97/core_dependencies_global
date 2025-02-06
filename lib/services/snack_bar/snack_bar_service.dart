import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SnackBarService {
  void showSnackBar({
    String? message,
    Color? backgroundColor,
    Color? textColor,
    SnackPosition? position,
    String? title,
    Duration? duration,
  });
}
