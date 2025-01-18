import 'package:core_dependencies_global/core_dependencies_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../app_container.dart';

class LoadingListview extends StatelessWidget {
  const LoadingListview({
    super.key,
    this.height,
    this.scrollDirection = Axis.horizontal,
    this.heightContainer,
    this.widthContainer,
    this.separatorBuilder,
  });

  final double? height;
  final Axis scrollDirection;
  final double? heightContainer;
  final double? widthContainer;
  final Widget? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 210.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.separated(
          scrollDirection: scrollDirection,
          shrinkWrap: true,
          itemCount: 6,
          separatorBuilder: (context, index) =>
              (scrollDirection == Axis.horizontal)
                  ? 20.widthBox___________________________()
                  : 20.heightBoxIIIIIIIIIIIIIIIIIIIIIIIIII(),
          itemBuilder: (context, index) {
            return AppContainer(
              width: widthContainer ?? 150,
              height: heightContainer ?? 120,
              borderRadius: 10,
            ); // replace this with your actual loading widget
          },
        ),
      ),
    );
  }
}
