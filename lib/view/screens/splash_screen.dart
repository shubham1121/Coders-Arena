import 'package:coders_arena/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:coders_arena/constants/image_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    precacheImage(const AssetImage(googleLogo), context);
    precacheImage(const AssetImage(loginSignupLogo), context);
    super.didChangeDependencies();
  }

  navigateToHome() async {
    if (mounted) {
      final navigator = Navigator.of(context);
      await Future.delayed(const Duration(seconds: 6));
      navigator.pushReplacementNamed('/AppRoot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: darkBlueColor,
      body: Center(
        child: Image.asset(splashScreenGif),
      ),
    ));
  }
}
