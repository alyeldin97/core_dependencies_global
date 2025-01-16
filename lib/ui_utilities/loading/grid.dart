import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../app_container.dart';

class LoadingGrid extends StatelessWidget {
  const LoadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.all(10.sp),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisExtent: 250,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 50.h,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const AppContainer(
                width: 50,
                height: 50,
                borderRadius: 10,
                isElevated: true,
              ),
            ),
          );
        },
        itemCount: 15,
      ),
    );
  }
}