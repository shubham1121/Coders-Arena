import 'dart:async';
import 'package:coders_arena/controller/verify_email_screen_controller.dart';
import 'package:coders_arena/services/firebase_services/firebase_auth.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final AuthService _authService = AuthService(FirebaseAuth.instance);
  final spaceProvider = SpaceProvider();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return SafeArea(child: Consumer<VerifyEmailScreenController>(
        builder: (context, controller, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const CustomisedAppBar(mainHeading: 'Coder\'s Arena', subHeading: '', isProfileSection: false),
                  controller.isMailSent
                      ? Text(
                          'A verification mail has been sent to your Email. Kindly logout first and then verify Email. You can resend email in every 30 seconds.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: displayWidth(context) * 0.05,
                            color: Colors.blue,
                          ),
                        )
                      : Text(
                          'Click on Verify Email to send verification email!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: displayWidth(context) * 0.05,
                            color: Colors.blue,
                          ),
                        ),
                  spaceProvider.getHeightSpace(context, 0.09),
                  controller.canResendEmail
                      ? ElevatedButton.icon(
                          onPressed: () {
                            reSendVerificationMail(controller);
                          },
                          icon: const Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          label: controller.isMailSent
                              ? Text(
                                  'Resend Email',
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.045,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Verify Email',
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.045,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          label: controller.isMailSent
                              ? Text(
                                  'Resend Email',
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.045,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Verify Email',
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.045,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                        ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _authService.logout(user!);
                      });
                    },
                    label: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }));
  }

  Future reSendVerificationMail(VerifyEmailScreenController controller) async {
    try {
      controller.sendOnce();
      controller.turnOffResendEmail();
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      debugPrint('Called Here');
      setState(() {
        Fluttertoast.showToast(
            msg: 'Email Sent Successfully',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green);
        debugPrint('called false');
      });
      await Future.delayed(const Duration(seconds: 60));
      controller.turnOnResendEmail();
    } catch (e) {
      setState(() {
        Fluttertoast.showToast(
            msg: 'Too Many Attempts Try Again Later',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.redAccent);
        controller.turnOnResendEmail();
      });
      debugPrint('${e}called catch error');
    }
  }
}
