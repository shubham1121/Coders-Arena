import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/custom_icon_text_button.dart';
import 'package:coders_arena/view/common_ui/profile_data_tile.dart';
import 'package:coders_arena/view/screens/chat/message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  final String uid;
  const UserDetailsScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    SpaceProvider spaceProvider = SpaceProvider();
    final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkBlueColor,
          body: Consumer<UserController>(
            builder: (context, controller, child) {
              if (controller.profileStatus == ProfileStatus.nil) {
                controller.setUser(currentUserUid);
              }
              switch (controller.profileStatus) {
                case ProfileStatus.nil:
                  return Center(
                    child: MaterialButton(
                      color: darkBlueColor,
                      onPressed: () {
                        controller.setUser(currentUserUid);
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
                  return const Loading();
                case ProfileStatus.fetched:
                  return FutureBuilder(
                      future: controller.getUser(widget.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          List<String> initials =
                              upperCaseConverter(snapshot.data!.name);
                          String uName = '';
                          for (int i = 0; i < initials.length; i++) {
                            if (i == initials.length - 1) {
                              uName = '$uName${initials[i]}';
                            } else {
                              uName = '$uName${initials[i]} ';
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        CupertinoIcons.arrow_left,
                                        size: displayWidth(context) * 0.08,
                                        color: Colors.white,
                                      ),
                                    ),
                                    spaceProvider.getWidthSpace(context, 0.05),
                                    Text(
                                      uName,
                                      style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.08,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data!.dp.isEmpty
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.pinkAccent,
                                              radius: 50,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: displayWidth(
                                                              context) *
                                                          0.007,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                  child: initials.length > 1
                                                      ? Text(
                                                          "${initials[0][0]}.${initials[initials.length - 1][0]}"
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  displayWidth(
                                                                          context) *
                                                                      0.12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : Text(
                                                          initials[0][0],
                                                          style: TextStyle(
                                                              fontSize:
                                                                  displayWidth(
                                                                          context) *
                                                                      0.12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 50,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: darkBlueColor,
                                                    width:
                                                        displayWidth(context) *
                                                            0.009,
                                                  ),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: displayWidth(
                                                              context) *
                                                          0.005,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          snapshot.data!.dp,
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                //followers and following counts
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Material(
                                            color: Colors.grey.shade300,
                                            clipBehavior: Clip.hardEdge,
                                            elevation: 5,
                                            shadowColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: CustomIconTextButton(
                                              buttonName: '',
                                              iconData: Icons.abc,
                                              isText: true,
                                              text: snapshot.data!.followers
                                                          .length >=
                                                      10
                                                  ? snapshot
                                                      .data!.followers.length
                                                      .toString()
                                                  : '0${snapshot.data!.followers.length}',
                                            ),
                                          ),
                                          spaceProvider.getHeightSpace(
                                              context, 0.01),
                                          Text(
                                            'Followers',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.04,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CustomIconTextButton(
                                              buttonName: '',
                                              iconData: Icons.abc,
                                              isText: true,
                                              text: snapshot.data!.following
                                                          .length >=
                                                      10
                                                  ? snapshot
                                                      .data!.followers.length
                                                      .toString()
                                                  : '0${snapshot.data!.following.length}',
                                            ),
                                          ),
                                          spaceProvider.getHeightSpace(
                                              context, 0.01),
                                          Text(
                                            'Following',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //profile data
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: ProfileDataTile(
                                    dataValue: snapshot.data!.email.toString(),
                                    iconName: gmailIcon,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: ProfileDataTile(
                                        dataValue:
                                            snapshot.data!.birthday.isEmpty
                                                ? '30th Feb'
                                                : snapshot.data!.birthday
                                                    .toString(),
                                        iconName: cakeIcon,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: ProfileDataTile(
                                        dataValue: snapshot.data!.about.isEmpty
                                            ? 'I am awesome!'
                                            : snapshot.data!.about.toString(),
                                        iconName: userIcon,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    controller.followingUserStatus ==
                                            FollowingUserStatus.yes
                                        ? const CircularProgressIndicator()
                                        : controller.user!.following
                                                .contains(snapshot.data!.userId)
                                            ? Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        controller.unFollowUser(
                                                            userId: snapshot
                                                                .data!.userId);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            lightBlueColor,
                                                      ),
                                                      child: Text(
                                                        'Unfollow',
                                                        style:
                                                            GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                            fontSize:
                                                                displayWidth(
                                                                        context) *
                                                                    0.04,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MessageScreen(
                                                                    recieverId:
                                                                        widget
                                                                            .uid,
                                                                    senderId:
                                                                        currentUserUid,
                                                                  )),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            lightBlueColor,
                                                      ),
                                                      child: Text(
                                                        'Message',
                                                        style:
                                                            GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                            fontSize:
                                                                displayWidth(
                                                                        context) *
                                                                    0.04,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        controller.followUser(
                                                            userId: snapshot
                                                                .data!.userId);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            lightBlueColor,
                                                      ),
                                                      child: Text(
                                                        'Follow',
                                                        style:
                                                            GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                            fontSize:
                                                                displayWidth(
                                                                        context) *
                                                                    0.04,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Loading();
                        }
                      });
              }
            },
          )),
    );
  }
}
