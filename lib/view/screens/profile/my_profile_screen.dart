import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/custom_icon_text_button.dart';
import 'package:coders_arena/view/common_ui/profile_data_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: displayWidth(context),
            height: displayHeight(context) * 0.25 + 60,
            // color: Colors.red,
            child: Stack(
              children: [
                Container(
                  width: displayWidth(context),
                  height: displayHeight(context) * 0.25,
                  decoration: const BoxDecoration(
                    color: lightBlueColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: darkBlueColor,
                          clipBehavior: Clip.hardEdge,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const CustomIconTextButton(
                              buttonName: 'Edit',
                              iconData: Icons.edit_outlined,
                            ),
                          ),
                        ),
                        Material(
                          color: darkBlueColor,
                          clipBehavior: Clip.hardEdge,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const CustomIconTextButton(
                              buttonName: 'Bye!',
                              iconData: Icons.logout_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: displayHeight(context) * 0.0119,
                  left: (displayWidth(context) * 0.5 -
                      58 -
                      displayWidth(context) * 0.005),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage: const AssetImage(tempDp),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: darkBlueColor,
                          width: displayWidth(context) * 0.009,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white,
                            width: displayWidth(context) * 0.005,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hi, Shubham',
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: displayWidth(context) * 0.09,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              spaceProvider.getHeightSpace(context, 0.02),
              const ProfileDataTile(
                dataViewType: 'Email',
                dataValue: 'devranishubham1121@gmail.com',
                iconData: Icons.email_outlined,
              ),
              const ProfileDataTile(
                dataViewType: 'Birthday',
                dataValue: '18th Oct',
                iconData: Icons.cake_outlined,
              ),
              const ProfileDataTile(
                dataViewType: 'About',
                dataValue: 'I am a flutter developer and a competitive programmer!',
                iconData: Icons.person_outline,
              ),
            ],
          )
        ],
      ),
    );
  }
}
