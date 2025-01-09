import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.width,
    this.height,
    this.strokeWidth = 3,
    this.color = Colors.white,
  });

  final double? width;
  final double? height;
  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: SizedBox(
        width: width ?? 50.w,
        height: height ?? 50.h,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            color: color,
          ),
        ),
      ),
    );
  }
}
