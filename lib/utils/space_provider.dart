import 'package:coders_arena/utils/device_size.dart';
import 'package:flutter/material.dart';

class SpaceProvider {
  Widget getWidthSpace (BuildContext context, double scaleFactor)
  {
    return SizedBox(
      width: displayWidth(context)*scaleFactor,
    );
  }
  Widget getHeightSpace (BuildContext context, double scaleFactor)
  {
    return SizedBox(
      width: displayHeight(context)*scaleFactor,
    );
  }
}