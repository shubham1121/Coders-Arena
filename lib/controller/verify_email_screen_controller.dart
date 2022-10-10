import 'package:flutter/material.dart';

class VerifyEmailScreenController with ChangeNotifier{
  bool isMailSent = false;
  bool canResendEmail = true;

  void turnOnResendEmail()
  {
    canResendEmail = true;
    notifyListeners();
  }
  void turnOffResendEmail()
  {
    canResendEmail = false;
    notifyListeners();
  }

  void sendOnce(){
    isMailSent = true;
  }

}