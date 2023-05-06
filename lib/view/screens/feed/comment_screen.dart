import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/model/search_users_model.dart';
import 'package:coders_arena/services/notification_services/notification_service.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/screens/feed/design_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen(this.postId, this.uid, {super.key});
  final String postId;
  final String uid;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _commentController.dispose();
    super.dispose();
  }

  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<FormState> _commentFormKey = GlobalKey<FormState>();
  SpaceProvider spaceProvider = SpaceProvider();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(
            children: [
              Text(
                'Comments',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: displayWidth(context) * 0.09,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              spaceProvider.getHeightSpace(context, 0.015),
              //add comment
              Column(
                children: [
                  Form(
                    key: _commentFormKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can\'t add empty comments';
                        } else {
                          return null;
                        }
                      },
                      controller: _commentController,
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.04,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      minLines: 1,
                      maxLines: 6,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
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
                        labelText: 'Comment',
                        labelStyle: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: displayWidth(context) * 0.055,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        hintText: 'Add a comment...',
                        hintStyle: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: displayWidth(context) * 0.04,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  spaceProvider.getHeightSpace(context, 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      // debugPrint(user!.uid);
                      if (_commentFormKey.currentState!.validate()) {
                        String commentText = _commentController.text;
                        _commentController.clear();
                        await addComment(
                            comment: commentText,
                            createdAt: DateTime.now().toString(),
                            postId: widget.postId,
                            userId: widget.uid);
                        debugPrint('comment added');
                        // _commentFormKey.currentState!.reset();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 20,
                      minimumSize: Size(displayWidth(context) * 1,
                          displayHeight(context) * 0.05),
                    ),
                    child: Text(
                      'Add Comment',
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: displayWidth(context) * 0.06,
                      ),
                    ),
                  ),
                ],
              ),
              //fetch comments from firebase
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.postId)
                      .collection('comments')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 20.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final commentData = documents[index].data()!
                                  as Map<String, dynamic>;
                              debugPrint(commentData['userId'].toString());
                              return Consumer<UserController>(
                                builder: (context, userController, child) {
                                  return DesignComment(
                                      userDetail: userController
                                          .allUsers[commentData['userId']]!,
                                      commentData: commentData);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 35.0,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
