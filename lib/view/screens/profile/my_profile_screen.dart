import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/bottom_modal_sheet.dart';
import 'package:coders_arena/view/common_ui/custom_icon_text_button.dart';
import 'package:coders_arena/view/common_ui/profile_data_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomModalSheet = BottomModalSheet();
    final spaceProvider = SpaceProvider();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // dp
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
                              isText: false,
                              text: '',
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
                              isText: false,
                              text: '',
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
              // Hi User Row
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
              spaceProvider.getHeightSpace(context, 0.04),
              // Followers Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Material(
                        color: Colors.grey.shade300,
                        clipBehavior: Clip.hardEdge,
                        elevation: 5,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) => bottomModalSheet.buildSheet(
                                  context, 'Followers'),
                            );
                          },
                          splashColor: Colors.grey.shade400,
                          child: const CustomIconTextButton(
                            buttonName: '',
                            iconData: Icons.abc,
                            isText: true,
                            text: '24',
                          ),
                        ),
                      ),
                      spaceProvider.getHeightSpace(context, 0.01),
                      Text(
                        'Followers',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: displayWidth(context) * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Material(
                        color: Colors.grey.shade300,
                        clipBehavior: Clip.hardEdge,
                        elevation: 5,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) => bottomModalSheet.buildSheet(
                                  context, 'My Posts'),
                            );
                          },
                          splashColor: Colors.grey.shade400,
                          child: const CustomIconTextButton(
                            buttonName: '',
                            iconData: Icons.abc,
                            isText: true,
                            text: '04',
                          ),
                        ),
                      ),
                      spaceProvider.getHeightSpace(context, 0.01),
                      Text(
                        'My Posts',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: displayWidth(context) * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Material(
                        color: Colors.grey.shade300,
                        clipBehavior: Clip.hardEdge,
                        elevation: 5,
                        shadowColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) => bottomModalSheet.buildSheet(
                                  context, 'Following'),
                            );
                          },
                          splashColor: Colors.grey.shade400,
                          child: const CustomIconTextButton(
                            buttonName: '',
                            iconData: Icons.abc,
                            isText: true,
                            text: '19',
                          ),
                        ),
                      ),
                      spaceProvider.getHeightSpace(context, 0.01),
                      Text(
                        'Following',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: displayWidth(context) * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              spaceProvider.getHeightSpace(context, 0.02),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ProfileDataTile(
                  dataValue: 'devranishubham1121@gmail.com',
                  iconName: gmailIcon,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: ProfileDataTile(
                  dataValue: '18th Oct',
                  iconName: cakeIcon,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: ProfileDataTile(
                  dataValue:
                      'I am a flutter developer and a competitive programmer!',
                  iconName: userIcon,
                ),
              ),
              spaceProvider.getHeightSpace(context, 0.06),
            ],
          ),
          spaceProvider.getHeightSpace(context, 0.13),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made in India with \u2764.',
                style: GoogleFonts.alegreya(
                  color: Colors.white,
                  fontSize: displayWidth(context) * 0.04,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
