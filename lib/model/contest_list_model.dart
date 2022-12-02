import 'package:coders_arena/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContestListModel {
  double duration;
  String endTime;
  String event;
  String host;
  String startTime;
  String contestStartDate;
  String contestEndDate;
  ContestListModel({
    required this.startTime,
    required this.duration,
    required this.endTime,
    required this.event,
    required this.host,
    required this.contestStartDate,
    required this.contestEndDate,
  });

  factory ContestListModel.fromJson(Map<String, dynamic> json) {
    // debugPrint(json["end"]);
    var dateTimeStartUtc =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json["start"], true);
    var dateTimeEndUtc =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json["end"], true);
    var contestStartIst = dateTimeStartUtc.toLocal();
    var contestEndIst = dateTimeEndUtc.toLocal();
    List<String> dateTimeStart = contestStartIst.toString().split(" ");
    List<String> dateTimeEnd = contestEndIst.toString().split(" ");
    List<String> dateSt = dateTimeStart[0].split("-");
    List<String> dateEnd = dateTimeEnd[0].split("-");
    String contestStDate =
        '${dateConverter(int.parse(dateSt[2]), int.parse(dateSt[1]))} ${dateSt[0]}';
    String contestEdDate =
        '${dateConverter(int.parse(dateEnd[2]), int.parse(dateEnd[1]))} ${dateEnd[0]}';

    debugPrint(contestStDate.toString());
    debugPrint(contestEdDate.toString());
    return ContestListModel(
      duration: (json["duration"]/(60*60)),
      endTime: dateTimeEnd[1].substring(0, 5),
      event: json["event"],
      host: json["host"],
      startTime: dateTimeStart[1].substring(0, 5),
      contestStartDate: contestStDate,
      contestEndDate: contestEdDate,
    );
  }
}
