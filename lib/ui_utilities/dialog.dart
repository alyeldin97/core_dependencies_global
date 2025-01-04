import 'package:flutter/material.dart';

class AppDialog {
  static Future<void> show(
      BuildContext context, {
        required String title,
        required String content,
        String confirmText = "OK",
        VoidCallback? onConfirm,
      }) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
