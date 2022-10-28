import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  bool isCaptionOpen = false;
  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    return Column(
      children: [
        spaceProvider.getHeightSpace(context, 0.08),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                backgroundImage: const AssetImage(tempDp),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: darkBlueColor,
                      width: displayWidth(context) * 0.003,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.white,
                        width: displayWidth(context) * 0.003,
                      ),
                    ),
                  ),
                ),
              ),
              spaceProvider.getWidthSpace(context, 0.04),
              Text(
                'Shubham Devrani',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: displayWidth(context) * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          tempDp,
          width: displayWidth(context),
          fit: BoxFit.fitWidth,
          height: displayHeight(context) * 0.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(
                  CupertinoIcons.heart,
                  size: displayWidth(context) * 0.075,
                  color: Colors.white,
                ),
                spaceProvider.getWidthSpace(context, 0.05),
                Icon(
                  CupertinoIcons.chat_bubble,
                  size: displayWidth(context) * 0.075,
                  color: Colors.white,
                ),
              ]),
              Icon(
                CupertinoIcons.bookmark,
                size: displayWidth(context) * 0.07,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            children: [
              isCaptionOpen
                  ? Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Shubham Devrani ',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayWidth(context) * 0.040,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Creating a coding environment in your college is not that easy. You have to put  efforts continuously with 100% efforts.'
                                  'Creating a coding environment in your college is not that easy. You have to put efforts continuously with 100% efforts.',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayWidth(context) * 0.035,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: RichText(
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Shubham Devrani ',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayWidth(context) * 0.040,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Creating a coding environment in your college is not that easy. You have to put efforts continuously with 100% efforts.'
                                  'Creating a coding environment in your college is not that easy. You have to put efforts continuously with 100% efforts.',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayWidth(context) * 0.035,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
        isCaptionOpen
            ? spaceProvider.getWidthSpace(context, 0)
            : TextButton(
                onPressed: () {
                  setState(() {
                    isCaptionOpen = true;
                  });
                },
                child: Text(
                  'View More',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: displayWidth(context) * 0.035,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
