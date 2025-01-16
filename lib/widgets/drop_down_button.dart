import 'package:flutter/material.dart';

class AppDropDownButton extends StatelessWidget {
  const AppDropDownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.color,
  });

  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: color ?? Colors.grey),
        ),
      ),
      items: items,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
