import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomIconTextButton extends StatelessWidget {

  final String buttonName;
  final IconData iconData;

  const CustomIconTextButton({
    Key? key,
    required this.buttonName,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
      child: Row(
        children: [
          Icon(iconData,
            color: Colors.white,
            size: displayWidth(context)*0.05,
          ),
          spaceProvider.getWidthSpace(context, 0.015),
          Text(buttonName,
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: displayWidth(context)*0.05,
              ),
            ),
          )
        ],
      ),
    );
  }
}