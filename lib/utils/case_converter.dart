import 'package:flutter/material.dart';

List<String> upperCaseConverter(String name) {
  List<String> initials = name.split(" ");

  for (int i = 0; i < initials.length; i++) {
    initials[i] =
        initials[i].characters.first.toUpperCase() + initials[i].substring(1);
  }
  debugPrint(initials.toString());
  return initials;
}
