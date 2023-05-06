import 'package:flutter/material.dart';

Map<int, String> monthConverter = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec',
};

String dateConverter(int day, int month) {
  String res = "";
  if (day >= 10 && day <= 20) {
    res += '${day}th ${monthConverter[month]!}';
  } else if (day % 10 == 1) {
    res += '${day}st ${monthConverter[month]!}';
  } else if (day % 10 == 2) {
    res += '${day}nd ${monthConverter[month]!}';
  } else if (day % 10 == 3) {
    res += '${day}rd ${monthConverter[month]!}';
  } else {
    res += '${day}th ${monthConverter[month]!}';
  }
  return res;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (from.difference(to).inHours / 24).round();
}
