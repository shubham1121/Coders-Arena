import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/user_model.dart';
import 'package:coders_arena/services/firebase_services/firebase_auth.dart';
import 'package:coders_arena/utils/all_providers.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/utils/my_posts_helper.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/bottom_modal_sheet.dart';
import 'package:coders_arena/view/common_ui/custom_icon_text_button.dart';
import 'package:coders_arena/view/common_ui/profile_data_tile.dart';
import 'package:coders_arena/view/screens/profile/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final bottomModalSheet = BottomModalSheet();
  final spaceProvider = SpaceProvider();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final currentUser = Provider.of<User>(context);
    return Consumer<UserController>(builder: (context, controller, child) {
      if (controller.profileStatus == ProfileStatus.nil) {
        debugPrint('Profile Status Loading');
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
          debugPrint('Profile Status Loading');
          return const Loading();
        case ProfileStatus.fetched:
          List<String> initials = controller.user!.name.split(" ");
          String firstLetter = "", lastLetter = "";

          if (initials.length == 1) {
            firstLetter = initials[0].characters.first;
          } else {
            firstLetter = initials[0].characters.first;
            lastLetter = initials[1].characters.first;
          }
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
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed('/editProfile');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                            fullName: controller.user!.name,
                                            about: controller.user!.about,
                                            birthday:
                                                controller.user!.birthday),
                                      ),
                                    );
                                  },
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
                                  onTap: () {
                                    final navigator = Navigator.of(context);
                                    AppProviders.disposeAllDisposableProviders(
                                        context);
                                    authService.logout(currentUser);
                                  },
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
                      controller.user!.dp.isEmpty
                          ? Positioned(
                              bottom: displayHeight(context) * 0.0119,
                              left: (displayWidth(context) * 0.5 -
                                  58 -
                                  displayWidth(context) * 0.005),
                              child: CircleAvatar(
                                backgroundColor: Colors.pinkAccent,
                                radius: 50,
                                child: Center(
                                  child: initials.length > 1
                                      ? Text(
                                          "$firstLetter$lastLetter"
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )
                                      : Text(
                                          firstLetter.toUpperCase(),
                                          style: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                            )
                          : Positioned(
                              bottom: displayHeight(context) * 0.0119,
                              left: (displayWidth(context) * 0.5 -
                                  58 -
                                  displayWidth(context) * 0.005),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 50,
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.user!.dp,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
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
                          'Hi, ${initials[0][0].toUpperCase()}${initials[0].substring(1)}',
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
                                    builder: (context) =>
                                        bottomModalSheet.buildSheetForFollowers(
                                            context, controller.myFollowers),
                                  );
                                },
                                splashColor: Colors.grey.shade400,
                                child: CustomIconTextButton(
                                  buttonName: '',
                                  iconData: Icons.abc,
                                  isText: true,
                                  text: controller.user!.followers.length >= 10
                                      ? controller.user!.followers.length
                                          .toString()
                                      : '0${controller.user!.followers.length}',
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
                        //My Posts
                        MyPostsHelper(
                            uid: controller.user!.userId, toFetch: true),
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
                                    builder: (context) =>
                                        bottomModalSheet.buildSheetForFollowing(
                                            context, controller.myFollowing),
                                  );
                                },
                                splashColor: Colors.grey.shade400,
                                child: CustomIconTextButton(
                                  buttonName: '',
                                  iconData: Icons.abc,
                                  isText: true,
                                  text: controller.user!.following.length >= 10
                                      ? controller.user!.followers.length
                                          .toString()
                                      : '0${controller.user!.following.length}',
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
                    //Profile Detail
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: ProfileDataTile(
                        dataValue: controller.user!.email.toString(),
                        iconName: gmailIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: ProfileDataTile(
                        dataValue: controller.user!.birthday.isEmpty
                            ? '30th Feb'
                            : controller.user!.birthday.toString(),
                        iconName: cakeIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: ProfileDataTile(
                        dataValue: controller.user!.about.isEmpty
                            ? 'I am awesome!'
                            : controller.user!.about.toString(),
                        iconName: userIcon,
                      ),
                    ),
                    spaceProvider.getHeightSpace(context, 0.06),
                  ],
                ),
              ],
            ),
          );
      }
    });
  }
}
