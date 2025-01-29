import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SnackBarService {
  void showSnackBar(
      {String? message,
      Color? backgroundColor,
      Color? textColor,
      SnackPosition? position,
      String? title,
      Duration? duration});
}

class SnackBarImpl implements SnackBarService {
  final String? title;
  final String message;
  final Color? backgroundColor;
  final Color? textColor;
  final SnackPosition? position;
  final Duration? duration;

  SnackBarImpl(
      {required this.title,
      required this.message,
      required this.backgroundColor,
      required this.textColor,
      required this.position,
      required this.duration});

  @override
  void showSnackBar(
      {String? message,
      Color? backgroundColor,
      Color? textColor,
      SnackPosition? position,
      String? title,
      Duration? duration}) {
    Get.snackbar(
      title ?? this.title ?? "",
      message ?? this.message,
      snackPosition: position ?? this.position ?? SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? this.backgroundColor ?? Colors.green,
      colorText: textColor ?? this.textColor ?? Colors.white,
      duration: duration ?? this.duration ?? Duration(seconds: 3),
    );
  }
}
