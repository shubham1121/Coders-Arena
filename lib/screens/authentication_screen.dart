import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userFullName = TextEditingController();
  TextEditingController userContactNumber = TextEditingController();
  TextEditingController userProfession = TextEditingController();
  TextEditingController userBelongsTo = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userEmail.dispose();
    userPassword.dispose();
    userFullName.dispose();
    userContactNumber.dispose();
    userProfession.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF1EFF7),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,50,10,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Hello Again',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                color:  Color(0xFF373248),
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            'Welcome back you\'ve',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                color:  Color(0xFF373248),
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            'been missed!',
                            style: GoogleFonts.nunito(

                              textStyle: const TextStyle(
                                color:  Color(0xFF373248),
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical:0),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(
                            fontSize:20,
                          ),
                          keyboardType:
                          TextInputType.emailAddress,
                          autofocus: false,
                          controller: userEmail,
                          decoration:  InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                            focusedBorder:
                              OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 5),
                            ),
                            hintText: 'Enter Email',
                            hintStyle:  GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            // labelText: 'Email',
                            // labelStyle: const TextStyle(
                            //   color: Colors.indigo,
                            //   fontSize:
                            //   15,
                            //   fontWeight: FontWeight.w500,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            fontSize:20,
                          ),
                          keyboardType:
                          TextInputType.emailAddress,
                          autofocus: false,
                          controller: userEmail,
                          decoration:  InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                            focusedBorder:
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 5),
                            ),
                            hintText: 'Enter Password',
                            hintStyle:  GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
              )),
        ),
      ),
    );
  }
}
