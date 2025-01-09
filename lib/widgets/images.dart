import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class AppSVGImage extends StatelessWidget {
  const AppSVGImage({
    super.key,
    required this.image,
    this.boxFit,
    this.height,
    this.width,
    this.color,
  });

  final String image;
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      height: height?.h,
      width: width?.w,
      color: color,
      fit: boxFit ?? BoxFit.contain,
    );
  }
}

class NetImage extends StatelessWidget {
  const NetImage({
    super.key,
    required this.imageUrl,
    this.url,
    this.height,
    this.width,
    this.errorHeight,
    this.errorWidth,
    this.fit,
    this.color,
    this.errorImageSVGPath,
    this.errorImageFit,
    this.imageBuilder,
  });

  final String imageUrl;
  final String? url;
  final double? height;
  final double? width;
  final double? errorHeight;
  final double? errorWidth;
  final BoxFit? fit;
  final Color? color;
  final String? errorImageSVGPath;
  final BoxFit? errorImageFit;
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      imageBuilder: imageBuilder,
      height: height,
      fit: fit ?? BoxFit.cover,
      color: color,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.grey[300]!,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(
        color: Colors.black,
        errorImageSVGPath ?? 'assets/images/logo.png',
        height: errorHeight ?? 30.0,
        width: errorWidth ?? 30.0,
        fit: BoxFit.contain,
      ),
    );
  }
}
