import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:coders_arena/controller/authentication_screen_controller.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/services/firebase_services/firebase_auth.dart'
    as firebase;
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:coders_arena/model/user_model.dart' as user;

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userFullName = TextEditingController();
  final firebase.AuthService _authService =
      firebase.AuthService(FirebaseAuth.instance);
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    precacheImage(const AssetImage(googleLogo), context);
    precacheImage(const AssetImage(loginSignupLogo), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    userEmail.dispose();
    userPassword.dispose();
    userFullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = SpaceProvider();
    return Material(
      child: SafeArea(
        child: Consumer<AuthScreenController>(
            builder: (context, controller, child) {
          return controller.authLoginSignupStatus ==
                  AuthLoginSignupStatus.loading
              ? Loading(false)
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: controller.loginFormStatus == LoginFormStatus.yes
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                spaceProvider.getWidthSpace(context, 0.06),
                                Image.asset(
                                  "assets/login_signup_image.jpg",
                                  fit: BoxFit.contain,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hello Again',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: const Color(0xFF373248),
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.09,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Welcome back you\'ve',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: const Color(0xFF373248),
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'been missed!',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: const Color(0xFF373248),
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                spaceProvider.getHeightSpace(context, 0.02),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 0),
                                  child: Form(
                                    key: _loginFormKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                          style: TextStyle(
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.w300,
                                            color: blackShadeColor,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          autofocus: false,
                                          controller: userEmail,
                                          cursorColor: blackShadeColor,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Email can\t be empty!';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: blackShadeColor,
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: blackShadeColor,
                                              ),
                                            ),
                                            hintText: 'Enter Email',
                                            hintStyle: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.03),
                                        TextFormField(
                                          style: TextStyle(
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          autofocus: false,
                                          obscureText:
                                              !controller.isPasswordVisible,
                                          controller: userPassword,
                                          cursorColor: blackShadeColor,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Password should be of min length 6';
                                            } else if (value.length < 6) {
                                              return 'Password should be of min length 6';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.lock_person,
                                              color: blackShadeColor,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                controller
                                                    .changeVisibilityOfPassword();
                                              },
                                              icon: Icon(
                                                controller.isPasswordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: blackShadeColor,
                                              ),
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: blackShadeColor,
                                              ),
                                            ),
                                            hintText: 'Enter Password',
                                            hintStyle: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.04),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_loginFormKey.currentState!
                                                    .validate() &&
                                                controller
                                                        .authLoginSignupStatus ==
                                                    AuthLoginSignupStatus
                                                        .notLoading) {
                                              final navigator =
                                                  Navigator.of(context);
                                              final sms =
                                                  ScaffoldMessenger.of(context);
                                              final userController =
                                                  Provider.of<UserController>(
                                                      context,
                                                      listen: false);
                                              controller.startLogin();
                                              dynamic loginResponse =
                                                  await _authService.loginUser(
                                                      userEmail.text.trim(),
                                                      userPassword.text.trim());
                                              debugPrint(
                                                  'Came here from login form');
                                              if (loginResponse.runtimeType ==
                                                  UserCredential) {
                                                await userController.setUser(
                                                    loginResponse.user.uid);
                                                controller.stopLogin();
                                                navigator.pushReplacementNamed(
                                                    '/AppRoot');
                                              } else {
                                                controller.stopLogin();
                                                sms.showSnackBar(
                                                  SnackBar(
                                                    content: Text(loginResponse
                                                        .toString()),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: blackShadeColor,
                                              elevation: 20,
                                              minimumSize: Size(
                                                  displayWidth(context) * 1,
                                                  displayHeight(context) *
                                                      0.05)),
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.05,
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.02),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 50),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                              Text(
                                                '  or  ',
                                                style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.05,
                                                    color:
                                                        Colors.grey.shade700),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.02),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            final navigator =
                                                Navigator.of(context);
                                            final sms =
                                                ScaffoldMessenger.of(context);
                                            final userController =
                                                Provider.of<UserController>(
                                                    context,
                                                    listen: false);
                                            dynamic signInResponse =
                                                await _authService
                                                    .signInWithGoogle();
                                            final googleUser =
                                                signInResponse.user;
                                            final bool isNewUser =
                                                signInResponse
                                                    .additionalUserInfo
                                                    .isNewUser;
                                            debugPrint(
                                                signInResponse.toString());
                                            if (signInResponse.runtimeType ==
                                                UserCredential) {
                                              if (isNewUser) {
                                                await userController.createUser(
                                                    user.User(
                                                        name: googleUser
                                                            .displayName
                                                            .toString()
                                                            .toLowerCase(),
                                                        dp: '',
                                                        email: googleUser.email,
                                                        followers: [],
                                                        userId: googleUser.uid,
                                                        about: '',
                                                        myPosts: [],
                                                        intrests: [],
                                                        birthday: '',
                                                        following: []));
                                              }
                                              navigator.pushReplacementNamed(
                                                  '/AppRoot');
                                            } else {
                                              sms.showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('$signInResponse'),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 20,
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.grey,
                                            minimumSize: Size(
                                                displayWidth(context) * 1,
                                                displayHeight(context) * 0.04),
                                            maximumSize: Size(
                                                displayWidth(context) * 1,
                                                displayHeight(context) * 0.05),
                                          ),
                                          icon: Image.asset(
                                            googleLogo,
                                            height:
                                                displayHeight(context) * 0.06,
                                            width: displayWidth(context) * 0.06,
                                          ),
                                          label: Text(
                                            'Login with Google',
                                            style: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.05,
                                              color: blackShadeColor,
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.025),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Don\'t have an account?',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.045,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller
                                                    .changeLoginFormStatus();
                                              },
                                              child: Text(
                                                'Signup',
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.045,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 2.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                spaceProvider.getHeightSpace(context, 0.06),
                                Image.asset(
                                  "assets/login_signup_image.jpg",
                                  fit: BoxFit.contain,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Create an Account',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: const Color(0xFF373248),
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.09,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Let\'s get socialize with',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: const Color(0xFF373248),
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Technology & Coding',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                color: const Color(0xFF373248),
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                spaceProvider.getHeightSpace(context, 0.02),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 0),
                                  child: Form(
                                    key: _signUpFormKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                          style: TextStyle(
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.w300,
                                            color: blackShadeColor,
                                          ),
                                          autofocus: false,
                                          controller: userFullName,
                                          cursorColor: blackShadeColor,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Name can\t be empty!';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: blackShadeColor,
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: blackShadeColor,
                                              ),
                                            ),
                                            hintText: 'Enter Full Name',
                                            hintStyle: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.03),
                                        TextFormField(
                                          style: TextStyle(
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.w300,
                                            color: blackShadeColor,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          autofocus: false,
                                          controller: userEmail,
                                          cursorColor: blackShadeColor,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Email can\t be empty!';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: blackShadeColor,
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: blackShadeColor,
                                              ),
                                            ),
                                            hintText: 'Enter Email',
                                            hintStyle: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.03),
                                        TextFormField(
                                          style: TextStyle(
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          autofocus: false,
                                          obscureText:
                                              !controller.isPasswordVisible,
                                          controller: userPassword,
                                          cursorColor: blackShadeColor,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Password should be of min length 6';
                                            } else if (value.length < 6) {
                                              return 'Password should be of min length 6';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.lock_person,
                                              color: blackShadeColor,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                controller
                                                    .changeVisibilityOfPassword();
                                              },
                                              icon: Icon(
                                                controller.isPasswordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: blackShadeColor,
                                              ),
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: blackShadeColor,
                                              ),
                                            ),
                                            hintText: 'Enter Password',
                                            hintStyle: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.04),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_signUpFormKey.currentState!
                                                    .validate() &&
                                                controller
                                                        .authLoginSignupStatus ==
                                                    AuthLoginSignupStatus
                                                        .notLoading) {
                                              final navigator =
                                                  Navigator.of(context);
                                              final sms =
                                                  ScaffoldMessenger.of(context);
                                              final userController =
                                                  Provider.of<UserController>(
                                                      context,
                                                      listen: false);
                                              controller.startSigningUp();
                                              dynamic signUpResponse =
                                                  await _authService.signUpUser(
                                                      userEmail.text.trim(),
                                                      userPassword.text.trim());
                                              controller.stopSigningUp();
                                              debugPrint(
                                                  'Came here from signup');
                                              if (signUpResponse.runtimeType ==
                                                  UserCredential) {
                                                await userController.createUser(
                                                    user.User(
                                                        name: userFullName.text
                                                            .trim()
                                                            .toLowerCase(),
                                                        dp: '',
                                                        email: userEmail.text
                                                            .trim(),
                                                        followers: [],
                                                        userId: signUpResponse
                                                            .user.uid,
                                                        about: '',
                                                        myPosts: [],
                                                        intrests: [],
                                                        birthday: '',
                                                        following: []));
                                                controller
                                                    .changeLoginFormStatus();
                                                navigator.pushReplacementNamed(
                                                    '/AppRoot');
                                              } else {
                                                sms.showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text('$signUpResponse'),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: blackShadeColor,
                                              elevation: 20,
                                              minimumSize: Size(
                                                  displayWidth(context) * 1,
                                                  displayHeight(context) *
                                                      0.05)),
                                          child: Text(
                                            'Create Account',
                                            style: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.05,
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.02),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 50),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                              Text(
                                                '  or  ',
                                                style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.05,
                                                    color:
                                                        Colors.grey.shade700),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.02),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            final navigator =
                                                Navigator.of(context);
                                            final sms =
                                                ScaffoldMessenger.of(context);
                                            final userController =
                                                Provider.of<UserController>(
                                                    context,
                                                    listen: false);
                                            dynamic signInResponse =
                                                await _authService
                                                    .signInWithGoogle();
                                            final googleUser =
                                                signInResponse.user;
                                            // debugPrint(googleUser.email.toString());
                                            if (signInResponse.runtimeType ==
                                                UserCredential) {
                                              await userController.createUser(
                                                user.User(
                                                    name: googleUser.displayName
                                                        .toString()
                                                        .toLowerCase(),
                                                    dp: '',
                                                    email: googleUser.email,
                                                    followers: [],
                                                    userId: googleUser.uid,
                                                    about: '',
                                                    myPosts: [],
                                                    intrests: [],
                                                    birthday: '',
                                                    following: []),
                                              );
                                              navigator.pushReplacementNamed(
                                                  '/AppRoot');
                                            } else {
                                              sms.showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('$signInResponse'),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 20,
                                            foregroundColor: Colors.grey,
                                            backgroundColor: Colors.white,
                                            minimumSize: Size(
                                                displayWidth(context) * 1,
                                                displayHeight(context) * 0.05),
                                            maximumSize: Size(
                                                displayWidth(context) * 1,
                                                displayHeight(context) * 0.05),
                                          ),
                                          icon: Image.asset(
                                            googleLogo,
                                            height:
                                                displayHeight(context) * 0.06,
                                            width: displayWidth(context) * 0.06,
                                          ),
                                          label: Text(
                                            'Signup with Google',
                                            style: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.05,
                                              color: blackShadeColor,
                                            ),
                                          ),
                                        ),
                                        spaceProvider.getHeightSpace(context, 0.025),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Already have an account?',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.045,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller
                                                    .changeLoginFormStatus();
                                              },
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.045,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 2.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                );
        }),
      ),
    );
  }
}
