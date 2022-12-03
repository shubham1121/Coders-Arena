import 'package:coders_arena/controller/disposable_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:flutter/material.dart';

class AuthScreenController extends DisposableProvider{
  AuthLoginSignupStatus authLoginSignupStatus = AuthLoginSignupStatus.notLoading;
  LoginFormStatus loginFormStatus = LoginFormStatus.yes;
  bool isPasswordVisible = false;

  startSigningUp() {
    authLoginSignupStatus = AuthLoginSignupStatus.loading;
    notifyListeners();
  }

  stopSigningUp() {
    authLoginSignupStatus = AuthLoginSignupStatus.notLoading;
    notifyListeners();
  }

  startLogin() {
    authLoginSignupStatus = AuthLoginSignupStatus.loading;
    notifyListeners();
  }

  stopLogin() {
    authLoginSignupStatus = AuthLoginSignupStatus.notLoading;
    notifyListeners();
  }

  void changeVisibilityOfPassword() {
    isPasswordVisible = ! isPasswordVisible;
    notifyListeners();
  }

  void changeLoginFormStatus(){
    if(loginFormStatus == LoginFormStatus.yes)
      {
        loginFormStatus = LoginFormStatus.no;
        notifyListeners();
      }
    else
      {
        loginFormStatus = LoginFormStatus.yes;
        notifyListeners();
      }

  }
  @override
  void disposeValues() {
    authLoginSignupStatus = AuthLoginSignupStatus.notLoading;
    loginFormStatus = LoginFormStatus.yes;
    isPasswordVisible = false;
  }

}