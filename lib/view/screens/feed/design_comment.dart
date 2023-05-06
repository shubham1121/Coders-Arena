import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/model/search_users_model.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignComment extends StatefulWidget {
  DesignComment({ required this.userDetail, required this.commentData, Key? key}) : super(key: key);
  final LowDetailUser userDetail;
  final dynamic commentData;


  @override
  State<DesignComment> createState() => _DesignCommentState();
}

class _DesignCommentState extends State<DesignComment> {

  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    // final User? currentUser = FirebaseAuth.instance.currentUser;
    List<String> initials = upperCaseConverter(widget.userDetail.name);
    String uName = '';
    for (int i = 0; i < initials.length; i++) {
      if (i == initials.length - 1) {
        uName = '$uName${initials[i]}';
      } else {
        uName = '$uName${initials[i]} ';
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.userDetail.dp.isEmpty
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
                radius: 20,
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
                        imageUrl: widget.userDetail.dp,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ),
              spaceProvider.getWidthSpace(context, 0.04),

              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // verticalDirection: VerticalDirection.down,
                children: [
                  Text(
                    uName,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: displayWidth(context) * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Container(
                    width: displayWidth(context) * 0.75,
                    child: Text(
                      widget.commentData['comment'],
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          // spaceProvider.getHeightSpace(context, 0.01),
          // spaceProvider.getWidthSpace(context, 0.08),

        ],
      ),
    );
  }
}
