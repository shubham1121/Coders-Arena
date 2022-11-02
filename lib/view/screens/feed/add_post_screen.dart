import 'dart:io';
import 'dart:ui';

import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _postFormKey = GlobalKey<FormState>();
  final spaceProvider = SpaceProvider();
  final TextEditingController _caption = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  final List<File> _imagesList = [];

  Future chooseImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    final file = File(pickedImage.path);
    _imagesList.add(file);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'New Post',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: displayWidth(context) * 0.07,
                  color: Colors.white,
                ),
              ),
            ),
            spaceProvider.getHeightSpace(context, 0.02),
            Form(
              key: _postFormKey,
              child: TextFormField(
                controller: _caption,
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.04,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
                minLines: 1,
                maxLines: 10,
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
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
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade400,
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
            spaceProvider.getHeightSpace(context, 0.04),
            _imagesList.length > 2
                ? SizedBox(
                    height: displayWidth(context) * 0.4,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Container(
                                height: 100,
                                width: 100,
                                child: Image.file(
                                  _imagesList[index],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : index == 1
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Image.file(
                                          _imagesList[index],
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned.fill(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 5,
                                              sigmaY: 5,
                                            ),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.red,
                                    child: InkWell(
                                      onTap: () {
                                        chooseImage();
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: displayWidth(context) * 0.2,
                                      ),
                                    ),
                                  );
                      },
                    ),
                  )
                : SizedBox(
                    height: displayWidth(context) * 0.4,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: _imagesList.length + 1,
                      itemBuilder: (context, index) {
                        return index == _imagesList.length
                            ? Container(
                                height: 100,
                                width: 100,
                                color: Colors.red,
                                child: InkWell(
                                  onTap: () {
                                    chooseImage();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: displayWidth(context) * 0.2,
                                  ),
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                // color: Colors.greenAccent,
                                child: Image.file(
                                  _imagesList[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                      },
                    ),
                  ),
            ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 20,
                minimumSize: Size(
                    displayWidth(context) * 1, displayHeight(context) * 0.05),
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
    );
  }
}
