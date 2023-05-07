import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/model/search_users_model.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/screens/chat/message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final spaceProvider = SpaceProvider();
  final currentUser = FirebaseAuth.instance.currentUser;
  int count = 0;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Consumer<UserController>(
          builder: (context, controller, child) {
            return Column(
              children: [
                // App Bar
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade800,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          splashRadius: 30,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: displayWidth(context) * 0.07,
                            color: Colors.white,
                          ),
                        ),
                        spaceProvider.getWidthSpace(context, 0.25),
                        Expanded(
                          child: Text(
                            'Chats',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: displayWidth(context) * 0.09,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('All Chats')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        // debugPrint(snapshot.data!.docs.toString());
                        // debugPrint(snapshot.data!.docs.length.toString());
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                String docId = snapshot.data!.docs[index].id;
                                List<String> ids = docId.split('_');
                                // ids.remove(currentUser!.uid);
                                if(ids.contains(currentUser!.uid)){
                                  ids.remove(currentUser!.uid);
                                  String recipientId = ids[0];
                                  debugPrint(docId);
                                  debugPrint(recipientId);
                                  debugPrint(currentUser!.uid);
                                  LowDetailUser recipientUser =
                                  controller.allUsers[recipientId]!;
                                  List<String> initials =
                                  upperCaseConverter(recipientUser.name);
                                  String uName = '';
                                  for (int i = 0; i < initials.length; i++) {
                                    if (i == initials.length - 1) {
                                      uName = '$uName${initials[i]}';
                                    } else {
                                      uName = '$uName${initials[i]} ';
                                    }
                                  }
                                  count++;
                                  return Padding(
                                    padding: (index == 0 || count==1)
                                        ? const EdgeInsets.fromLTRB(0, 10, 0, 0)
                                        : const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MessageScreen(
                                                      recieverId:
                                                      recipientUser.userId,
                                                      senderId: currentUser!.uid,
                                                    )));
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 0),
                                            child: Row(
                                              children: [
                                                recipientUser.dp.isEmpty
                                                    ? CircleAvatar(
                                                  backgroundColor:
                                                  Colors.pinkAccent,
                                                  radius: 19,
                                                  child: Center(
                                                    child: initials.length >
                                                        1
                                                        ? Text(
                                                      "${initials[0][0]}.${initials[initials.length - 1][0]}"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize:
                                                          displayWidth(context) *
                                                              0.045,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          color: Colors
                                                              .white),
                                                    )
                                                        : Text(
                                                      initials[0][0],
                                                      style: TextStyle(
                                                          fontSize:
                                                          displayWidth(context) *
                                                              0.11,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          color: Colors
                                                              .white),
                                                    ),
                                                  ),
                                                )
                                                    : CircleAvatar(
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  radius: 20,
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(50),
                                                      border: Border.all(
                                                        color:
                                                        darkBlueColor,
                                                        width: displayWidth(
                                                            context) *
                                                            0.003,
                                                      ),
                                                    ),
                                                    child: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            50),
                                                        border: Border.all(
                                                          color:
                                                          Colors.white,
                                                          width: displayWidth(
                                                              context) *
                                                              0.003,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20),
                                                        child:
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                          recipientUser
                                                              .dp,
                                                          placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                spaceProvider.getWidthSpace(
                                                    context, 0.04),
                                                Text(
                                                  uName,
                                                  style: GoogleFonts.nunito(
                                                    textStyle: TextStyle(
                                                      fontSize:
                                                      displayWidth(context) *
                                                          0.04,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey.shade800,
                                            thickness: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                                // debugPrint(recipient.name);

                              }),
                        );
                      }
                      return const Center(
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 70.0,
                        ),
                      );
                    })
              ],
            );
          },
        ),
      ),
    );
  }
}
