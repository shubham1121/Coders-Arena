import 'package:cached_network_image/cached_network_image.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/model/post_model.dart';
import 'package:coders_arena/model/search_users_model.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/user_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignPost extends StatefulWidget {
  const DesignPost({Key? key, required this.postModel, required this.lowDetailUser})
      : super(key: key);
  final PostModel postModel;
  final LowDetailUser? lowDetailUser;

  @override
  State<DesignPost> createState() => _DesignPostState();
}

class _DesignPostState extends State<DesignPost> {
  bool isCaptionOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => loadImages());
  }

  Future loadImages() async {
    await Future.wait(widget.postModel.imageUrls
        .map((urlImage) => cacheImage(context, urlImage))
        .toList());
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    List<String> initials = upperCaseConverter(widget.lowDetailUser!.name);
    String uName = '';
    for (int i = 0; i < initials.length; i++) {
      if (i == initials.length - 1) {
        uName = '$uName${initials[i]}';
      } else {
        uName = '$uName${initials[i]} ';
      }
    }
    debugPrint(widget.postModel.caption.length.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: [
          // spaceProvider.getHeightSpace(context, 0.08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: GestureDetector(
              onTap: () {
                if(widget.lowDetailUser!.userId!= currentUser!.uid)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return  UserDetailsScreen(uid:widget.lowDetailUser!.userId);
                    }));
                  }
              },
              child: Row(
                children: [
                  widget.lowDetailUser!.dp.isEmpty
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
                                  imageUrl: widget.lowDetailUser!.dp,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                  spaceProvider.getWidthSpace(context, 0.04),
                  Text(
                    uName,
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
          ),
          SizedBox(
            height: displayHeight(context) * 0.5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.postModel.imageUrls.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.postModel.imageUrls[index],
                    fit: BoxFit.fitWidth,
                    width: displayWidth(context),
                    height: displayHeight(context) * 0.5,
                    // placeholder: (context, url) =>
                    //     const CircularProgressIndicator(),
                  );
                }),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //             GestureDetector(
          //               onTap: (){
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Coming Soon!',
          //                       style: GoogleFonts.lato(
          //                         textStyle: TextStyle(
          //                           fontSize: displayWidth(context) * 0.04,
          //                         ),
          //                       ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                     elevation: 10,
          //                     duration: const Duration(milliseconds: 600),
          //                     width: displayWidth(context) * 0.33,
          //                     behavior: SnackBarBehavior.floating,
          //                     backgroundColor: Colors.black,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(10),
          //                     ),
          //                   ),
          //                 );
          //               },
          //               child: Icon(
          //                 CupertinoIcons.heart,
          //                 size: displayWidth(context) * 0.075,
          //                 color: Colors.white,
          //               ),
          //
          //             ),
          //             spaceProvider.getWidthSpace(context, 0.05),
          //             GestureDetector(
          //               onTap: (){
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Coming Soon!',
          //                       style: GoogleFonts.lato(
          //                         textStyle: TextStyle(
          //                           fontSize: displayWidth(context) * 0.04,
          //                         ),
          //                       ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                     elevation: 10,
          //                     duration: const Duration(milliseconds: 600),
          //                     width: displayWidth(context) * 0.33,
          //                     behavior: SnackBarBehavior.floating,
          //                     backgroundColor: Colors.black,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(10),
          //                     ),
          //                   ),
          //                 );
          //               },
          //               child: Icon(
          //                 CupertinoIcons.chat_bubble,
          //                 size: displayWidth(context) * 0.075,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ]),
          //           GestureDetector(
          //             onTap: (){
          //               ScaffoldMessenger.of(context).showSnackBar(
          //                 SnackBar(
          //                   content: Text(
          //                     'Coming Soon!',
          //                     style: GoogleFonts.lato(
          //                       textStyle: TextStyle(
          //                         fontSize: displayWidth(context) * 0.04,
          //                       ),
          //                     ),
          //                     textAlign: TextAlign.center,
          //                   ),
          //                   elevation: 10,
          //                   duration: const Duration(milliseconds: 600),
          //                   width: displayWidth(context) * 0.33,
          //                   behavior: SnackBarBehavior.floating,
          //                   backgroundColor: Colors.black,
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                   ),
          //                 ),
          //               );
          //             },
          //             child: Icon(
          //               CupertinoIcons.bookmark,
          //               size: displayWidth(context) * 0.07,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           // spaceProvider.getWidthSpace(context, 0.02),
          //           Text(widget.postModel.likes.toString(),
          //             style: GoogleFonts.nunito(
          //               textStyle: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: displayWidth(context) * 0.045,
          //                 fontWeight: FontWeight.w700,
          //               ),
          //             ),
          //           ),
          //           Text(' Likes',
          //             style: GoogleFonts.nunito(
          //               textStyle: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: displayWidth(context) * 0.04,
          //               ),
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
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
                                text: '$uName ',
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: displayWidth(context) * 0.040,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: widget.postModel.caption,
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
                                text: '$uName ',
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: displayWidth(context) * 0.040,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: widget.postModel.caption,
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
              : widget.postModel.caption.length > 95
                  ? GestureDetector(
                      onTap: () {
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
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    )
                  : spaceProvider.getHeightSpace(context, 0),
        ],
      ),
    );
  }
}
