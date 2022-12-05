import 'package:coders_arena/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'device_size.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: darkBlueColor,
      body: Container(
        color: darkBlueColor,
        child: const Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size:70.0,
          ),
        ),
      ),
    );
  }
}

class SmallLoadingIndicatorForImages extends StatelessWidget {
  const SmallLoadingIndicatorForImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: darkBlueColor,
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: displayWidth(context) * 0.05,
          ),
        ),
      ),
    );
  }
}