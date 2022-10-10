import 'package:coders_arena/services/firebase_user_service.dart';
import 'package:coders_arena/view/screens/authentication_screen.dart';
import 'package:coders_arena/view/screens/home_screen.dart';
import 'package:coders_arena/view/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, notifier, child) {
        return notifier.user != null ? notifier.user!.emailVerified ? const HomeScreen() : const VerifyEmailPage() : const Wrapper();
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
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return firebaseUser.emailVerified ? const HomeScreen() : const VerifyEmailPage();
    } else {
      return const AuthenticationScreen();
    }
  }
}
