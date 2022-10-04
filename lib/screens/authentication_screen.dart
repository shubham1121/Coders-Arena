import 'package:coders_arena/services/firebase_auth.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/loading.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userFullName = TextEditingController();
  final AuthService _authService = AuthService();
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isLoginForm = true;
  bool isLoading = false;
  final List<Color> backgroundGradientColors = const [
    Color(0xFFF2F1FB),
    Color(0xFFDFE5F5),
    Color(0xFFE7E8F0)
  ];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    precacheImage(const AssetImage("assets/google_logo.png"), context);
    precacheImage(const AssetImage("assets/login_signup_image.jpg"), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    userEmail.dispose();
    userPassword.dispose();
    userFullName.dispose();
    super.dispose();
  }

  validateAndRegister(context) async {
    if (_signUpFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      dynamic result =
      await _authService.signUpUser(userEmail.text, userPassword.text);
      if (result == null) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('We got an error'),
            ),
          );
        });
      }
    }
  }

  authenticateAndLogin(context) async {
    setState(() {
      isLoading = true;
    });
    dynamic result =
    await _authService.loginUser(userEmail.text, userPassword.text);
    if (result != 'valid') {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.toString()),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: isLoading ? Loading(false) : Scaffold(
          backgroundColor: Colors.white,
          body: isLoginForm
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.06,
                        ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello Again',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF373248),
                                        fontSize: displayWidth(context) * 0.09,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Welcome back you\'ve',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF373248),
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'been missed!',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF373248),
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0),
                          child: Form(
                            key: _loginFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xFF111727),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  controller: userEmail,
                                  cursorColor: const Color(0xFF111727),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email can\t be empty!';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Color(0xFF111727),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF111727),
                                      ),
                                    ),
                                    hintText: 'Enter Email',
                                    hintStyle: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.03,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  autofocus: false,
                                  obscureText: !isPasswordVisible,
                                  controller: userPassword,
                                  cursorColor: const Color(0xFF111727),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password should be of min length 6';
                                    } else if (value.length < 6) {
                                      return 'Password should be of min length 6';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_person,
                                      color: Color(0xFF111727),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xFF111727),
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF111727),
                                      ),
                                    ),
                                    hintText: 'Enter Password',
                                    hintStyle: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.04,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    authenticateAndLogin(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF111727),
                                      elevation: 20,
                                      minimumSize: Size(
                                          displayWidth(context) * 1,
                                          displayHeight(context) * 0.05)),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),
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
                                                displayWidth(context) * 0.05,
                                            color: Colors.grey.shade700),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),

                                ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 20,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.grey,
                                    minimumSize: Size(displayWidth(context) * 1,
                                        displayHeight(context) * 0.04),
                                    maximumSize: Size(displayWidth(context) * 1,
                                        displayHeight(context) * 0.05),
                                  ),
                                  icon: Image.asset(
                                    'assets/google_logo.png',
                                    height: displayHeight(context) * 0.06,
                                    width: displayWidth(context) * 0.06,
                                  ),
                                  label: Text(
                                    'Login with Google',
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                      color: const Color(0xFF111727),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: displayHeight(context) * 0.025,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: displayWidth(context) * 0.045,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isLoginForm = false;
                                        });
                                      },
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize:
                                              displayWidth(context) * 0.045,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
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
                        SizedBox(
                          height: displayHeight(context) * 0.06,
                        ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Create an Account',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF373248),
                                        fontSize: displayWidth(context) * 0.09,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Let\'s get socialize with',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF373248),
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Technology & Coding',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF373248),
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0),
                          child: Form(
                            key: _signUpFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xFF111727),
                                  ),
                                  autofocus: false,
                                  controller: userFullName,
                                  cursorColor: const Color(0xFF111727),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name can\t be empty!';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Color(0xFF111727),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF111727),
                                      ),
                                    ),
                                    hintText: 'Enter Full Name',
                                    hintStyle: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.03,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xFF111727),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  controller: userEmail,
                                  cursorColor: const Color(0xFF111727),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email can\t be empty!';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Color(0xFF111727),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF111727),
                                      ),
                                    ),
                                    hintText: 'Enter Email',
                                    hintStyle: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.03,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  autofocus: false,
                                  obscureText: !isPasswordVisible,
                                  controller: userPassword,
                                  cursorColor: const Color(0xFF111727),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password should be of min length 6';
                                    } else if (value.length < 6) {
                                      return 'Password should be of min length 6';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_person,
                                      color: Color(0xFF111727),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xFF111727),
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF111727),
                                      ),
                                    ),
                                    hintText: 'Enter Password',
                                    hintStyle: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.04,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    validateAndRegister(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF111727),
                                      elevation: 20,
                                      minimumSize: Size(
                                          displayWidth(context) * 1,
                                          displayHeight(context) * 0.05)),
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),
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
                                                displayWidth(context) * 0.05,
                                            color: Colors.grey.shade700),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 20,
                                    foregroundColor: Colors.grey,
                                    backgroundColor: Colors.white,
                                    minimumSize: Size(displayWidth(context) * 1,
                                        displayHeight(context) * 0.05),
                                    maximumSize: Size(displayWidth(context) * 1,
                                        displayHeight(context) * 0.05),
                                  ),
                                  icon: Image.asset(
                                    'assets/google_logo.png',
                                    height: displayHeight(context) * 0.06,
                                    width: displayWidth(context) * 0.06,
                                  ),
                                  label: Text(
                                    'Signup with Google',
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                      color: const Color(0xFF111727),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: displayHeight(context) * 0.025,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: displayWidth(context) * 0.045,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isLoginForm = true;
                                        });
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize:
                                              displayWidth(context) * 0.045,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
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
        ),
      ),
    );
  }
}
