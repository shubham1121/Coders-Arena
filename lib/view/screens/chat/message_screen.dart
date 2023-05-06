import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/search_users_model.dart';
import 'package:coders_arena/services/notification_services/notification_service.dart';
import 'package:coders_arena/utils/case_converter.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  final String recieverId;
  final String senderId;
  const MessageScreen(
      {Key? key, required this.recieverId, required this.senderId})
      : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  final spaceProvider = SpaceProvider();
  final TextEditingController messageController = TextEditingController();
  final messageFormKey = GlobalKey<FormState>();
  late String personalMessageId = '';

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    personalMessageId = widget.senderId.compareTo(widget.recieverId) > 0
        ? '${widget.senderId}_${widget.recieverId}'
        : '${widget.recieverId}_${widget.senderId}';
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int prevWeekday = -1;
    // String prevDate = '';
    // List<bool> weekDaysStatus = List.filled(8, false);
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkBlueColor,
          body: Consumer<UserController>(
            builder: (context, controller, child) {
              if (controller.profileStatus == ProfileStatus.nil) {
                controller.setUser(FirebaseAuth.instance.currentUser!.uid);
              }
              switch (controller.profileStatus) {
                case ProfileStatus.nil:
                  return Center(
                    child: MaterialButton(
                      color: darkBlueColor,
                      onPressed: () {
                        controller
                            .setUser(FirebaseAuth.instance.currentUser!.uid);
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
                  debugPrint(personalMessageId);
                  LowDetailUser recipientUser =
                      controller.allUsers[widget.recieverId]!;
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
                  return Column(
                    children: [
                      // AppBar
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
                              horizontal: 15, vertical: 10.0),
                          child: Row(
                            children: [
                              recipientUser.dp.isEmpty
                                  ? CircleAvatar(
                                      backgroundColor: Colors.pinkAccent,
                                      radius: 20,
                                      child: Center(
                                        child: initials.length > 1
                                            ? Text(
                                                "${initials[0][0]}.${initials[initials.length - 1][0]}"
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.05,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                initials[0][0],
                                                style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.12,
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: darkBlueColor,
                                            width:
                                                displayWidth(context) * 0.003,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: Colors.white,
                                              width:
                                                  displayWidth(context) * 0.003,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              imageUrl: recipientUser.dp,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
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
                                    fontSize: displayWidth(context) * 0.09,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Messages
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('All Chats')
                              .doc(personalMessageId)
                              .collection('chat')
                              .orderBy('createdAt', descending: true)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.hasData) {
                              debugPrint(snapshots.data.toString());
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: ListView.builder(
                                      reverse: true,
                                      controller: scrollController,
                                      itemCount:
                                          snapshots.data!.docs.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index ==
                                            snapshots.data!.docs.length) {
                                          return const SizedBox(height: 10);
                                        }
                                        // if(index == 0)
                                        //   {
                                        //     prevWeekday = -1;
                                        //     prevDate = '';
                                        //   }
                                        // else
                                        //   {
                                        //     prevWeekday = DateTime.parse(
                                        //         snapshots.data!.docs[index-1]
                                        //         ['createdAt'])
                                        //         .weekday;
                                        //     prevDate = DateFormat.yMMMMd()
                                        //         .format(DateTime.parse(
                                        //         snapshots.data!.docs[index-1]
                                        //         ['createdAt']));
                                        //   }
                                        // int weekday = DateTime.parse(
                                        //         snapshots.data!.docs[index]
                                        //             ['createdAt'])
                                        //     .weekday;
                                        // int diffrenceInDays = daysBetween(
                                        //     DateTime.now(),
                                        //     DateTime.parse(
                                        //         snapshots.data!.docs[index]
                                        //             ['createdAt']));
                                        // String messageDate = DateFormat.yMMMMd()
                                        //     .format(DateTime.parse(
                                        //         snapshots.data!.docs[index]
                                        //             ['createdAt']));
                                        // String messageDay = DateFormat.EEEE()
                                        //     .format(DateTime.parse(
                                        //     snapshots.data!.docs[index]
                                        //     ['createdAt']));
                                        // debugPrint('index : $index');
                                        // debugPrint( 'prev : $prevWeekday');
                                        // debugPrint( 'current Weekday : $weekday');
                                        // debugPrint('prevDate : $prevDate');
                                        // debugPrint( snapshots.data!.docs[index]['message'] + ' ' + messageDate);
                                        if (snapshots.data!.docs[index]
                                                ['senderId'] ==
                                            widget.senderId) {
                                          // Sender's Side
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Column(
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.fromLTRB(
                                                //       0, 0, 0, 10),
                                                //   child: Row(
                                                //     mainAxisAlignment: MainAxisAlignment.center,
                                                //     children: [
                                                //       diffrenceInDays > 6 ?
                                                //           prevDate == messageDate ? const SizedBox(width: 0, height: 0) :
                                                //       Material(
                                                //         color: Colors.grey,
                                                //         elevation: 10,
                                                //         borderRadius: BorderRadius.circular(50),
                                                //         child: Padding(
                                                //           padding: const EdgeInsets.all(8.0),
                                                //           child: Text(
                                                //             messageDate,
                                                //             style: GoogleFonts.nunito(
                                                //               textStyle: TextStyle(
                                                //                 fontSize: displayWidth(context) * 0.04,
                                                //                 color: Colors.white,
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ):
                                                //           prevWeekday == weekday ? const SizedBox(width: 0, height: 0) :
                                                //       Material(
                                                //         color: Colors.grey,
                                                //         elevation: 10,
                                                //         borderRadius: BorderRadius.circular(50),
                                                //         child: Padding(
                                                //           padding: const EdgeInsets.all(8.0),
                                                //           child: Text(
                                                //             messageDay,
                                                //             style: GoogleFonts.nunito(
                                                //               textStyle: TextStyle(
                                                //                 fontSize: displayWidth(context) * 0.04,
                                                //                 color: Colors.white,
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       )
                                                //     ],
                                                //   ),
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Material(
                                                      color: lightBlueColor,
                                                      elevation: 10,
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        bottomLeft:
                                                            Radius.circular(15),
                                                        bottomRight:
                                                            Radius.circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        children: [
                                                          // Message
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal: 10,
                                                                    vertical: 10),
                                                            child: Container(
                                                              constraints: BoxConstraints(
                                                                  maxWidth:
                                                                      displayWidth(
                                                                              context) *
                                                                          0.6),
                                                              child: Text(
                                                                snapshots.data!
                                                                        .docs[index]
                                                                    ['message'],
                                                                style: GoogleFonts
                                                                    .nunito(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        displayWidth(
                                                                                context) *
                                                                            0.04,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          // Time
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal: 10,
                                                                    vertical: 0),
                                                            child: Container(
                                                              constraints: BoxConstraints(
                                                                  maxWidth:
                                                                      displayWidth(
                                                                              context) *
                                                                          0.6),
                                                              child: Text(
                                                                DateFormat(
                                                                        'hh:mm a')
                                                                    .format(
                                                                  DateTime.parse(snapshots
                                                                              .data!
                                                                              .docs[
                                                                          index][
                                                                      'createdAt']),
                                                                ),
                                                                style: GoogleFonts
                                                                    .nunito(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        displayWidth(
                                                                                context) *
                                                                            0.03,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        // Receiver's side
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Material(
                                                color: Colors.white,
                                                elevation: 10,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    // Message
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: Container(
                                                        constraints: BoxConstraints(
                                                            maxWidth:
                                                            displayWidth(
                                                                context) *
                                                                0.6),
                                                        child: Text(
                                                          snapshots.data!
                                                              .docs[index]
                                                          ['message'],

                                                          textAlign: TextAlign.start,
                                                          style: GoogleFonts
                                                              .nunito(
                                                            textStyle:
                                                            TextStyle(
                                                              fontSize:
                                                              displayWidth(
                                                                  context) *
                                                                  0.04,
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Time
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 0),
                                                      child: Container(
                                                        constraints: BoxConstraints(
                                                            maxWidth:
                                                            displayWidth(
                                                                context) *
                                                                0.6),
                                                        child: Text(
                                                          DateFormat(
                                                              'hh:mm a')
                                                              .format(
                                                            DateTime.parse(snapshots
                                                                .data!
                                                                .docs[
                                                            index][
                                                            'createdAt']),
                                                          ),
                                                          textAlign: TextAlign.end,
                                                          style: GoogleFonts
                                                              .nunito(
                                                            textStyle:
                                                            TextStyle(
                                                              fontSize:
                                                              displayWidth(
                                                                  context) *
                                                                  0.03,
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              );
                            }
                            return Expanded(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: displayWidth(context) * 0.05,
                              ),
                            );
                          }),
                      // Send Message
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Form(
                          key: messageFormKey,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Name can\'t be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: messageController,
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.045,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                  textAlignVertical: TextAlignVertical.top,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.multiline,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade900,
                                    filled: true,
                                    focusColor: Colors.grey.shade900,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    hintText: 'Message...',
                                    hintStyle: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.04,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              spaceProvider.getWidthSpace(context, 0.02),
                              Container(
                                decoration: BoxDecoration(
                                  color: lightBlueColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    if (messageFormKey.currentState!
                                        .validate()) {
                                      debugPrint(
                                          DateTime.now().toLocal().toString());
                                      sendPersonalMessage(
                                        message: messageController.text,
                                        personalMessageId: personalMessageId,
                                        senderId: widget.senderId,
                                        receiverId: widget.recieverId,
                                        createdAt:
                                            DateTime.now().toLocal().toString(),
                                      );
                                      scrollController.animateTo(
                                        scrollController
                                            .position.minScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      );
                                      messageController.clear();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
              }
            },
          )),
    );
  }
}
