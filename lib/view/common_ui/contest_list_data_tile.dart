import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/model/contest_list_model.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContestListTile extends StatelessWidget {
  final ContestListModel contestListModel;
  const ContestListTile({Key? key, required this.contestListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> host = contestListModel.host.split(".");
    host[0] = host[0].characters.first.toUpperCase() +
        host[0].substring(1, host[0].length);
    // List<String> event = contestListModel.event.split(" ");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    host[0],
                    style: GoogleFonts.nunito(
                      fontSize: displayWidth(context) * 0.08,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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
                        color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        contestListModel.contestStartDate,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        contestListModel.startTime,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                      contestListModel.duration > 100 ? Text(
                        '100 +',
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
                        ),
                      ) :
                      Text(
                        contestListModel.duration.toString(),
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'hours',
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        contestListModel.contestEndDate,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        contestListModel.endTime,
                        style: GoogleFonts.nunito(
                          fontSize: displayWidth(context) * 0.04,
                          color: Colors.white,
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
