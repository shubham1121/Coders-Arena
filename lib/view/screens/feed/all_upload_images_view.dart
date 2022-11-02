import 'dart:io';

import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/add_post_screen_controller.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllUploadImagesView extends StatefulWidget {
  const AllUploadImagesView({Key? key}) : super(key: key);

  @override
  State<AllUploadImagesView> createState() => _AllUploadImagesViewState();
}

class _AllUploadImagesViewState extends State<AllUploadImagesView> {
  @override
  Widget build(BuildContext context) {
    final addPostScreenController = Provider.of<AddPostScreenController>(context);
    final spaceProvider = SpaceProvider();
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Images',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              spaceProvider.getHeightSpace(context, 0.04),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                    ),
                    itemCount: addPostScreenController.uploadImages.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          addPostScreenController.uploadImages[index],
                          // height: displayHeight(context) * 0.117,
                          // width: displayHeight(context) * 0.117,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
