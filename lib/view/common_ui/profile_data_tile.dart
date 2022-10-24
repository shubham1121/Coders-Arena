import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDataTile extends StatelessWidget {

  // final String dataViewType;
  final String dataValue;
  final String iconName;

  const ProfileDataTile({
    Key? key,
    // required this.dataViewType,
    required this.dataValue,
    required this.iconName,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                iconName,
                height: displayWidth(context)*0.06,
                width: displayWidth(context)*0.06,
              ),
              spaceProvider.getWidthSpace(context, 0.04),
            ],
          ),
          Expanded(
            child: Text(dataValue,
              // overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: displayWidth(context)*0.040,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}