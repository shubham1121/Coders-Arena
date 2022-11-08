import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
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
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    // final TextEditingController fullName = TextEditingController();
    // final TextEditingController about = TextEditingController();
    // final TextEditingController birthday = TextEditingController();
    final updateProfileForm = GlobalKey<FormState>();
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
            List<String> initials = controller.user!.name.split(" ");
            String firstLetter = "", lastLetter = "";

            if (initials.length == 1) {
              firstLetter = initials[0].characters.first;
            } else {
              firstLetter = initials[0].characters.first;
              lastLetter = initials[1].characters.first;
            }
            final TextEditingController fullName = TextEditingController(
                text:
                    '${firstLetter.toUpperCase()}${initials[0].substring(1)} ${lastLetter.toUpperCase()}${initials[1].substring(1)}');
            final TextEditingController about =
                TextEditingController(text: controller.user!.about);
            final TextEditingController birthday =
                TextEditingController(text: controller.user!.birthday);

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
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    await Future.delayed(
                                        Duration(milliseconds: 100));
                                    Navigator.of(context).pop();
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
                                    controller: fullName,
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
                                    controller: about,
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
                                    controller: birthday,
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
                                        birthday.text = dateConverter(
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
                                debugPrint(fullName.text);
                                debugPrint(about.text);
                                controller.updateProfile(
                                  name: fullName.text,
                                  about: about.text,
                                  birthday: birthday.text,
                                );
                                Navigator.of(context).pop();
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
