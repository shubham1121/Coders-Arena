import 'package:coders_arena/controller/disposable_controller.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreenController extends DisposableProvider{
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

  @override
  void disposeValues() {
    canResendEmail = true;
    isMailSent = false;
  }

}