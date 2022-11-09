import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/date_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final String fullName;
  final String about;
  final String birthday;
  const EditProfile(
      {Key? key,
      required this.fullName,
      required this.about,
      required this.birthday})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController fullNameController;
  late TextEditingController aboutController;
  late TextEditingController birthdayController;

  @override
  void initState() {
    super.initState();
    List<String> initials = upperCaseConverter(widget.fullName);
    String tempName = "";
    for (int i = 0; i < initials.length; i++) {
      if (i == initials.length - 1) {
        tempName = '$tempName${initials[i]}';
      } else {
        tempName = '$tempName${initials[i]} ';
      }
    }
    fullNameController = TextEditingController(text: tempName);
    aboutController = TextEditingController(text: widget.about);
    birthdayController = TextEditingController(text: widget.birthday);
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    final updateProfileForm = GlobalKey<FormState>();
    discardKeyboard() async {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
    }

    return SafeArea(
      child: Consumer<UserController>(builder: (context, controller, child) {
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
            return Scaffold(
                backgroundColor: darkBlueColor,
                body: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  splashRadius: 25,
                                  onPressed: () {
                                    discardKeyboard().whenComplete(
                                        () => Navigator.of(context).pop());
                                  },
                                  icon: Icon(
                                    CupertinoIcons.arrow_left,
                                    size: displayWidth(context) * 0.08,
                                    color: Colors.white,
                                  ),
                                ),
                                spaceProvider.getWidthSpace(context, 0.2),
                                Text(
                                  'Edit Profile',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: displayWidth(context) * 0.07,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            spaceProvider.getHeightSpace(context, 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.userUploadingImage ==
                                        UserUploadingImage.loading
                                    ? const CircularProgressIndicator()
                                    : CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 60,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            border: Border.all(
                                              color: darkBlueColor,
                                              width:
                                                  displayWidth(context) * 0.009,
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: displayWidth(context) *
                                                    0.005,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: CachedNetworkImage(
                                                imageUrl: controller.user!.dp,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            spaceProvider.getHeightSpace(context, 0.01),
                            ElevatedButton(
                              onPressed: () {
                                controller.chooseImage();
                              },
                              child: Text(
                                'Change',
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                  ),
                                ),
                              ),
                            ),
                            spaceProvider.getHeightSpace(context, 0.03),
                            Form(
                              key: updateProfileForm,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: fullNameController,
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 8),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      labelText: 'Full Name',
                                      labelStyle: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                          fontSize:
                                              displayWidth(context) * 0.055,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      hintText: 'Alex',
                                      hintStyle: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                          fontSize:
                                              displayWidth(context) * 0.04,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'About can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: aboutController,
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 8),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      labelText: 'About',
                                      labelStyle: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                          fontSize:
                                              displayWidth(context) * 0.055,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      hintText: 'Flutter Developer',
                                      hintStyle: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                          fontSize:
                                              displayWidth(context) * 0.04,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    controller: birthdayController,
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 8),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      labelText: 'Birthday',
                                      labelStyle: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                          fontSize:
                                              displayWidth(context) * 0.055,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      hintText: 'Alex',
                                      hintStyle: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                          fontSize:
                                              displayWidth(context) * 0.04,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:
                                            DateTime(DateTime.now().year),
                                        lastDate:
                                            DateTime(DateTime.now().year + 1),
                                      );
                                      if (pickedDate != null) {
                                        birthdayController.text = dateConverter(
                                            pickedDate.day, pickedDate.month);
                                      } else {
                                        debugPrint('Date not Picked!');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            spaceProvider.getHeightSpace(context, 0.03),
                            ElevatedButton(
                              onPressed: () {
                                debugPrint(fullNameController.text);
                                debugPrint(aboutController.text);
                                controller.updateProfile(
                                  name: fullNameController.text
                                      .trim()
                                      .toLowerCase(),
                                  about: aboutController.text.trim(),
                                  birthday: birthdayController.text,
                                );
                                discardKeyboard().whenComplete(
                                  () => Navigator.of(context).pop(),
                                );
                              },
                              child: Text(
                                'Update Profile',
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
        }
      }),
    );
  }
}
