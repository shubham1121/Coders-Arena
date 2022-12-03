import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/user_model.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomisedAppBar extends StatelessWidget {
  const CustomisedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade800,
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Coder\'s Arena',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: displayWidth(context) * 0.099,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: displayWidth(context) * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700)),
              child: Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //   padding: EdgeInsets.zero,
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.add_box_outlined,
                    //     color: Colors.white,
                    //     size: displayWidth(context) * 0.06,
                    //   ),
                    // ),
                    // spaceProvider.getWidthSpace(context, 0.01),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Coming Soon!',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: displayWidth(context) * 0.04,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            elevation: 10,
                            duration: const Duration(milliseconds: 600),
                            width: displayWidth(context) * 0.33,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                        size: displayWidth(context) * 0.055,
                      ),
                    ),
                    spaceProvider.getWidthSpace(context, 0.005),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Coming Soon!',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: displayWidth(context) * 0.04,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            elevation: 10,
                            duration: const Duration(milliseconds: 600),
                            width: displayWidth(context) * 0.33,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.chat_bubble_text,
                        color: Colors.white,
                        size: displayWidth(context) * 0.055,
                      ),
                    ),
                    // spaceProvider.getWidthSpace(context, 0.01),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    Consumer<UserController>(
      builder: (context, controller, child) {
        if (controller.profileStatus == ProfileStatus.nil) {
          controller.setUser(FirebaseAuth.instance.currentUser!.uid);
        }
        switch (controller.profileStatus) {
          case ProfileStatus.nil:
            return Center(
              child: MaterialButton(
                color: darkBlueColor,
                onPressed: () {
                  controller.setUser(FirebaseAuth.instance.currentUser!.uid);
                },
                child: const Text(
                  'Refresh Profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          case ProfileStatus.loading:
            return Loading(false);
          case ProfileStatus.fetched:
            List<String> initials = controller.user!.name.split(" ");
            String firstLetter = "", lastLetter = "";

            if (initials.length == 1) {
              firstLetter = initials[0].characters.first;
            } else {
              firstLetter = initials[0].characters.first;
              lastLetter = initials[1].characters.first;
            }
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade800,
                    width: 2,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CoCuit',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: displayWidth(context) * 0.11,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade700)),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_box_outlined,
                                color: Colors.white,
                                size: displayWidth(context) * 0.06,
                              ),
                            ),
                            spaceProvider.getWidthSpace(context, 0.01),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.white,
                                size: displayWidth(context) * 0.06,
                              ),
                            ),
                            spaceProvider.getWidthSpace(context, 0.04),
                            Material(
                              shape: const CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.transparent,
                              child: CircleAvatar(
                                maxRadius: 12,
                                backgroundColor: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.grey.shade500,
                                  onTap: () {},
                                  child: CachedNetworkImage(
                                    imageUrl: controller.user!.dp,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            ),
                            spaceProvider.getWidthSpace(context, 0.03),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
