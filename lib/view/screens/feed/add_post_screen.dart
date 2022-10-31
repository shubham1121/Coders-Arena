import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _postFormKey = GlobalKey<FormState>();
  final spaceProvider = SpaceProvider();
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
            spaceProvider.getHeightSpace(context, 0.03),
            // GridView.builder(
            //     shrinkWrap: true,
            //     scrollDirection:
            //     Axis.vertical,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //     ),
            //     itemBuilder: (context, index) => Container()),
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
