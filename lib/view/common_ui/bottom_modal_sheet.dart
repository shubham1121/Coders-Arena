import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/model/post_model.dart';
import 'package:coders_arena/model/user_model.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomModalSheet {
  Widget makeDismissible(
          {required Widget child, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildSheetForFollowers(BuildContext context, List<UserModel>followers) {
    final spaceProvider = SpaceProvider();
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Followers',
                    style: GoogleFonts.nunito(
                      fontSize: displayWidth(context) * 0.065,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: followers.length,
                      itemBuilder: (context,index){
                        List<String> initials = upperCaseConverter(followers[index].name);
                        String uName = '';
                        for (int i = 0; i < initials.length; i++) {
                          if (i == initials.length - 1) {
                            uName = '$uName${initials[i]}';
                          } else {
                            uName = '$uName${initials[i]} ';
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //dp and username
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  followers[index].dp.isEmpty
                                      ? CircleAvatar(
                                    backgroundColor: Colors.pinkAccent,
                                    radius: 20,
                                    child: Center(
                                      child: initials.length > 1
                                          ? Text(
                                        "${initials[0][0]}.${initials[initials.length - 1][0]}"
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                          : Text(
                                        initials[0][0],
                                        style: TextStyle(
                                            fontSize: displayWidth(context) * 0.12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
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
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: followers[index].dp,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //   backgroundColor: Colors.transparent,
                                  //   radius: 25,
                                  //   backgroundImage: const AssetImage(tempDp),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(50),
                                  //       border: Border.all(
                                  //         color: darkBlueColor,
                                  //         width: displayWidth(context) * 0.003,
                                  //       ),
                                  //     ),
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //         borderRadius:
                                  //         BorderRadius.circular(50),
                                  //         border: Border.all(
                                  //           color: Colors.white,
                                  //           width:
                                  //           displayWidth(context) * 0.003,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  spaceProvider.getWidthSpace(context, 0.02),
                                  Text(
                                    uName,
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlueColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Unfollow Button
                              // ElevatedButton(
                              //   onPressed: () {},
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: lightBlueColor,
                              //   ),
                              //   child: Text(
                              //     'Follow',
                              //     style: GoogleFonts.nunito(
                              //       textStyle: TextStyle(
                              //         fontSize: displayWidth(context) * 0.04,
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
  Widget buildSheetForFollowing(BuildContext context, List<UserModel>following) {
    final spaceProvider = SpaceProvider();
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Following',
                    style: GoogleFonts.nunito(
                      fontSize: displayWidth(context) * 0.065,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: following.length,
                      itemBuilder: (context,index){
                        List<String> initials = upperCaseConverter(following[index].name);
                        String uName = '';
                        for (int i = 0; i < initials.length; i++) {
                          if (i == initials.length - 1) {
                            uName = '$uName${initials[i]}';
                          } else {
                            uName = '$uName${initials[i]} ';
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //dp and username
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  following[index].dp.isEmpty
                                      ? CircleAvatar(
                                    backgroundColor: Colors.pinkAccent,
                                    radius: 25,
                                    child: Center(
                                      child: initials.length > 1
                                          ? Text(
                                        "${initials[0][0]}.${initials[initials.length - 1][0]}"
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                          : Text(
                                        initials[0][0],
                                        style: TextStyle(
                                            fontSize: displayWidth(context) * 0.12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                      : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
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
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: following[index].dp,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //   backgroundColor: Colors.transparent,
                                  //   radius: 25,
                                  //   backgroundImage: const AssetImage(tempDp),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(50),
                                  //       border: Border.all(
                                  //         color: darkBlueColor,
                                  //         width: displayWidth(context) * 0.003,
                                  //       ),
                                  //     ),
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //         borderRadius:
                                  //         BorderRadius.circular(50),
                                  //         border: Border.all(
                                  //           color: Colors.white,
                                  //           width:
                                  //           displayWidth(context) * 0.003,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  spaceProvider.getWidthSpace(context, 0.02),
                                  Text(
                                    uName,
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlueColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Unfollow Button
                              // ElevatedButton(
                              //   onPressed: () {},
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: lightBlueColor,
                              //   ),
                              //   child: Text(
                              //     'Follow',
                              //     style: GoogleFonts.nunito(
                              //       textStyle: TextStyle(
                              //         fontSize: displayWidth(context) * 0.04,
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
  Widget buildSheetForMyPosts(BuildContext context, List<PostModel>myPosts) {
    final spaceProvider = SpaceProvider();
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'MyPosts',
                    style: GoogleFonts.nunito(
                      fontSize: displayWidth(context) * 0.065,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: myPosts.length,
                      itemBuilder: (context,index){
                        return Container(

                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
