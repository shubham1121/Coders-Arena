import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomModalSheet {
  Widget makeDismissible(
          {required Widget child, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildSheet(BuildContext context, String windowType) {
    final spaceProvider = SpaceProvider();
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    windowType,
                    style: GoogleFonts.nunito(
                      fontSize: displayWidth(context) * 0.065,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: controller,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //dp and username
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    backgroundImage: const AssetImage(tempDp),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.white,
                                            width:
                                                displayWidth(context) * 0.003,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  spaceProvider.getWidthSpace(context, 0.02),
                                  Text(
                                    'Shubham Devrani',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlueColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Unfollow Button
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightBlueColor,
                                ),
                                child: Text(
                                  'Follow',
                                  style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                      fontSize: displayWidth(context) * 0.04,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
