import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final BoxFit? boxFit;
  final String backGroundImg;
  final double? topMargin;
  final double? bottomMargin;
  final double? startMargin;
  final double? endMargin;
  final double? topPadding;
  final double? bottomPadding;
  final double? startPadding;
  final double? endPadding;
  final double? borderRadius;
  final double? width;
  final double? height;
  final bool isElevated;
  final double xShadow;
  final bool isCircle;
  final double yShadow;
  final Color? color;
  final Color? shadowColor;
  final Color? borderColor;
  final void Function()? onPressed;

  const AppContainer({
    super.key,
    this.child,
    this.boxFit = BoxFit.none,
    this.backGroundImg = "",
    this.onPressed,
    this.topMargin = 0.0,
    this.isElevated = false,
    this.color = Colors.white,
    this.shadowColor,
    this.borderColor = Colors.transparent,
    this.topPadding = 0.0,
    this.endMargin = 0.0,
    this.endPadding = 0.0,
    this.startMargin = 0.0,
    this.startPadding = 0.0,
    this.bottomMargin = 0.0,
    this.bottomPadding = 0.0,
    this.borderRadius = 0.0,
    this.xShadow = 1.0,
    this.yShadow = 4.0,
    this.isCircle = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        width: width?.w,
        height: height?.h,
        decoration: BoxDecoration(
          image: backGroundImg.isEmpty
              ? null
              : DecorationImage(
                  image: AssetImage(
                    backGroundImg,
                  ),
                  // NetworkImage(
                  //   backGroundImg,
                  // ),
                  fit: boxFit,
                ),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          boxShadow: !isElevated
              ? []
              : [
                  BoxShadow(
                    color: borderColor!,
                    blurRadius: 2.5.w,
                    spreadRadius: -2.0.w,
                    offset: Offset(
                        xShadow.w, yShadow.h), // shadow direction: bottom right
                  )
                ],
          color: color,
          border: borderColor == null
              ? Border.all(color: borderColor!)
              : Border.all(color: borderColor!),
          borderRadius: isCircle ? null : BorderRadius.circular(borderRadius!),
        ),
        margin: EdgeInsetsDirectional.only(
          end: endMargin!.w,
          top: topMargin!.h,
          start: startMargin!.w,
          bottom: bottomMargin!.h,
        ),
        padding: EdgeInsetsDirectional.only(
          end: endPadding!.w,
          top: topPadding!.h,
          start: startPadding!.w,
          bottom: bottomPadding!.h,
        ),
        child: child,
      ),
    );
  }
}
