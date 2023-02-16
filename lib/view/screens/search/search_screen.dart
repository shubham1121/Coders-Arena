import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/shimmer.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final Shimmer shimmer = Shimmer();
    final SpaceProvider spaceProvider = SpaceProvider();
    final TextEditingController searchQuery = TextEditingController();
    bool shouldEmpty = true;
    return Consumer<UserController>(
      builder: (context, userController, child) {
        if(shouldEmpty) {
          userController.queryRes.clear();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Find Similar',
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: displayWidth(context) * 0.09,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              spaceProvider.getHeightSpace(context, 0.03),
              TextFormField(
                // onTap: () {
                //   debugPrint('Trying to call');
                //   userController.searchUser(searchQuery.text.toLowerCase());
                // },
                onChanged: (value) {
                  debugPrint('Trying to call');
                  shouldEmpty = false;
                  userController.searchUser(value.toLowerCase());
                },
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.05,
                  fontWeight: FontWeight.w300,
                ),
                autofocus: false,
                controller: searchQuery,
                cursorColor: darkBlueColor,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  // focusColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: darkBlueColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  hintText: 'Search User',
                  hintStyle: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: displayWidth(context) * 0.05,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: userController.queryRes.isEmpty
                    ? Center(
                        child: Text(
                          'No User Found',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: userController.queryRes.length,
                          itemBuilder: (context, index) {
                            List<String> initials = upperCaseConverter(userController.queryRes[index].name);
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
                                  horizontal: 0, vertical: 10),
                              child: ListTile(
                                onTap: () {
                                  if (userController.user!.userId !=
                                      userController.queryRes[index].userId) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return UserDetailsScreen(
                                          uid: userController
                                              .queryRes[index].userId);
                                    }));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'It\'s you!',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04,
                                            ),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        elevation: 10,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        width: displayWidth(context) * 0.25,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                leading: Text(
                                  uName,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    color: darkBlueColor,
                                    fontSize: displayWidth(context) * 0.06,
                                  )),
                                ),
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                visualDensity: VisualDensity.comfortable,
                              ),
                            );
                          },
                          shrinkWrap: true,
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
