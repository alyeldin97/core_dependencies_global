import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.height, this.width, this.color});

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 1.h,
      width: width ?? double.infinity,
      child: Divider(
        color: color ?? Colors.grey,
      ),
    );
  }
}
