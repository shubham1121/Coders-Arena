import 'dart:collection';
import 'dart:ui';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/add_post_screen_controller.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/screens/feed/all_upload_images_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _postFormKey = GlobalKey<FormState>();
  final spaceProvider = SpaceProvider();
  final TextEditingController _caption = TextEditingController();

  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addPostScreenController =
        Provider.of<AddPostScreenController>(context);
    final user = Provider.of<User?>(context);
    return Consumer<AddPostScreenController>(
      builder: (context, controller, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'New Post',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        fontSize: displayWidth(context) * 0.09,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                spaceProvider.getHeightSpace(context, 0.02),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _postFormKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return 'Caption can\'t be null';
                            } else if (controller.uploadImages.isEmpty) {
                              return 'Please upload at least one image';
                            } else {
                              return controller.captionValidator(value)
                                  ? null
                                  : 'Caption is not related to any technical stuff!';
                            }
                          },
                          controller: _caption,
                          style: TextStyle(
                            fontSize: displayWidth(context) * 0.04,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          minLines: 1,
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          textAlignVertical: TextAlignVertical.top,
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
                            labelText: 'Caption',
                            labelStyle: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: displayWidth(context) * 0.055,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade200,
                              ),
                            ),
                            hintText: 'Got rank under 50 in CF div 2.',
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          'Images',
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                            fontSize: displayWidth(context) * 0.07,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      // Row can contain at most three boxes according to conditions
                      // Case 1 : If no image is picked ( _imageList.length == 0 ) , then only a box to add images will appear
                      // Case 2 : If only one image is picked , two boxes -> one will be the image and second will be the box to add more
                      // Case 3 : If images picked are 2 or more than 2
                      // Case 3.1 -> If there are only 2 images in the list then display three boxes
                      //          -> First and second will be image boxes and third will be the box to add more
                      // Case 3.2 -> If there are more than 2 images , display three boxes
                      //          -> First will be image box , second will be a stack with two children and third will be box to add more

                      // Add Images Row
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // First image box
                            addPostScreenController.uploadImages.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      addPostScreenController
                                          .uploadImages.first,
                                      height: displayHeight(context) * 0.117,
                                      width: displayHeight(context) * 0.117,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : spaceProvider.getWidthSpace(context, 0),
                            // Horizontal space only if first image box is present
                            addPostScreenController.uploadImages.length == 1
                                ? spaceProvider.getWidthSpace(context, 0)
                                : spaceProvider.getWidthSpace(context, 0),

                            addPostScreenController.uploadImages.length >= 2
                                ? spaceProvider.getWidthSpace(context, 0.066)
                                : spaceProvider.getWidthSpace(context, 0),
                            //
                            addPostScreenController.uploadImages.length >= 2
                                ? addPostScreenController.uploadImages.length ==
                                        2
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          addPostScreenController
                                              .uploadImages[1],
                                          height:
                                              displayHeight(context) * 0.117,
                                          width: displayHeight(context) * 0.117,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllUploadImagesView(),
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox(
                                          height:
                                              displayHeight(context) * 0.117,
                                          width: displayHeight(context) * 0.117,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Opacity(
                                                opacity: 0.3,
                                                child: ClipRRect(
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.file(
                                                    addPostScreenController
                                                        .uploadImages[1],
                                                    height:
                                                        displayHeight(context) *
                                                            0.117,
                                                    width:
                                                        displayHeight(context) *
                                                            0.117,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '+${addPostScreenController.uploadImages.length - 2}',
                                                style: GoogleFonts.nunito(
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.07,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                : spaceProvider.getWidthSpace(context, 0),
                            // Horizontal space only if second image box is present
                            addPostScreenController.uploadImages.isNotEmpty
                                ? spaceProvider.getWidthSpace(context, 0.066)
                                : spaceProvider.getWidthSpace(context, 0),
                            //
                            Material(
                              elevation: 10,
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade800,
                              child: InkWell(
                                onTap: () {
                                  addPostScreenController.chooseImage();
                                },
                                child: Container(
                                  height: displayHeight(context) * 0.117,
                                  width: displayHeight(context) * 0.117,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                      size: displayWidth(context) * 0.15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Post Button
                      ElevatedButton(
                        onPressed: () async {
                          debugPrint(user!.uid);
                          if (_postFormKey.currentState!.validate() &&
                              controller.uploadImages.isNotEmpty) {
                            controller.publishPost(user.uid, _caption.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 20,
                          minimumSize: Size(displayWidth(context) * 1,
                              displayHeight(context) * 0.05),
                        ),
                        child: Text(
                          'Post',
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: displayWidth(context) * 0.06,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
