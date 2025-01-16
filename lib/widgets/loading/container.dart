import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../app_container.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const AppContainer(
        width: double.infinity,
        height: 100,
        borderRadius: 10,

      ),
    );
  }
}
