import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/my_posts_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/bottom_modal_sheet.dart';
import 'package:coders_arena/view/common_ui/custom_icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyPostsHelper extends StatefulWidget {
  final String uid;
  const MyPostsHelper({Key? key, required this.uid}) : super(key: key);

  @override
  State<MyPostsHelper> createState() => _MyPostsHelperState();
}

class _MyPostsHelperState extends State<MyPostsHelper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyPostsController>(
        builder: (context, myPostController, child) {
      if (myPostController.fetchingMyPosts == FetchingMyPosts.nil) {
        myPostController.fetchMyPosts(widget.uid);
      }
      switch (myPostController.fetchingMyPosts) {
        case FetchingMyPosts.nil:
          return Center(
            child: MaterialButton(
              color: darkBlueColor,
              onPressed: () {
                myPostController.fetchMyPosts(widget.uid);
              },
              child: const Text(
                'Refresh Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        case FetchingMyPosts.fetching:
          return const CircularProgressIndicator();
        case FetchingMyPosts.fetched:
          SpaceProvider spaceProvider = SpaceProvider();
          final bottomModalSheet = BottomModalSheet();
          return Column(
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
                          bottomModalSheet.buildSheetForMyPosts(
                              context,
                              myPostController.myPublishedPosts,
                              myPostController),
                    );
                  },
                  splashColor: Colors.grey.shade400,
                  child: CustomIconTextButton(
                    buttonName: '',
                    iconData: Icons.abc,
                    isText: true,
                    text: myPostController.myPublishedPosts.length >= 10
                        ? myPostController.myPublishedPosts.length.toString()
                        : '0${myPostController.myPublishedPosts.length}',
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
          );
      }
    });

    // Class end
  }
}
