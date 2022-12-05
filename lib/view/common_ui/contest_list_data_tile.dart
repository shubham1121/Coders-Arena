import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/model/contest_list_model.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/icons_decider.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContestListTile extends StatelessWidget {
  final ContestListModel contestListModel;
  const ContestListTile({Key? key, required this.contestListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SpaceProvider spaceProvider = SpaceProvider();
    List<String> host = contestListModel.host.split(".");
    host[0] = host[0].characters.first.toUpperCase() +
        host[0].substring(1, host[0].length);
    // List<String> event = contestListModel.event.split(" ");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image(
                        width: displayWidth(context)*0.06,
                        height: displayWidth(context)*0.06,
                        image: AssetImage(contestHostIcons[host[0]]!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  spaceProvider.getWidthSpace(context, 0.03),
                  Text(
                    host[0],
                    style: GoogleFonts.nunito(
                      fontSize: displayWidth(context) * 0.085,
                      color: darkBlueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      contestListModel.event,
                      style: GoogleFonts.nunito(
                        fontSize: displayWidth(context) * 0.06,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start',
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                      Text(
                        contestListModel.contestStartDate,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                      Text(
                        contestListModel.startTime,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration',
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                      contestListModel.duration > 100
                          ? Text(
                              '100 +',
                              style: GoogleFonts.nunito(
                                fontSize: displayWidth(context) * 0.04,
                                color: darkBlueColor,
                              ),
                            )
                          : Text(
                              contestListModel.duration.toString(),
                              style: GoogleFonts.nunito(
                                fontSize: displayWidth(context) * 0.04,
                                color: darkBlueColor,
                              ),
                            ),
                      Text(
                        'hours',
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End',
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                      Text(
                        contestListModel.contestEndDate,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                      Text(
                        contestListModel.endTime,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: darkBlueColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
