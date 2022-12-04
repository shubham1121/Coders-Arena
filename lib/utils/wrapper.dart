import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/add_post_screen_controller.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/services/firebase_services/firebase_user_service.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:coders_arena/view/screens/authentication/authentication_screen.dart';
import 'package:coders_arena/view/screens/authentication/verify_email_screen.dart';
import 'package:coders_arena/view/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, notifier, child) {
        if (notifier.user == null) {
          debugPrint('user null here');
        }
        return notifier.user == null
            ? const Wrapper()
            : notifier.user!.emailVerified
                ? Consumer<AddPostScreenController>(
                    builder: (context, controller, child) {
                    return controller.postUploadingStatus ==
                            PostUploadingStatus.uploading
                        ? const Loading()
                        : const HomeScreen();
                  })
                : const VerifyEmailPage();
      },
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // final firebaseUser = Provider.of<User?>(context);
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return firebaseUser.emailVerified
          ? Consumer<AddPostScreenController>(
              builder: (context, controller, child) {
              return controller.postUploadingStatus ==
                      PostUploadingStatus.uploading
                  ? const Loading()
                  : Consumer<UserController>(
                builder: (context,userController,child) {
                  if (userController.profileStatus == ProfileStatus.nil) {
                    userController.setUser(
                        FirebaseAuth.instance.currentUser!.uid);
                  }
                  switch (userController.profileStatus) {
                    case ProfileStatus.nil:
                      return Center(
                        child: MaterialButton(
                          color: darkBlueColor,
                          onPressed: () {
                            userController.setUser(FirebaseAuth.instance
                                .currentUser!.uid);
                          },
                          child: const Text(
                            'Refresh Profile',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    case ProfileStatus.loading:
                      return const Loading();
                    case ProfileStatus.fetched:
                      return const HomeScreen();
                  }
                }
              );
            })
          : const VerifyEmailPage();
    } else {
      return const AuthenticationScreen();
    }
  }
}
