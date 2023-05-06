import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:flutter/material.dart';
import 'package:coders_arena/constants/image_constants.dart';
import 'package:google_fonts/google_fonts.dart';

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
      await Future.delayed(const Duration(milliseconds: 1150));
      navigator.pushReplacementNamed('/appRoot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkBlueColor,
      body: Center(
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText('Coder\'s Arena',
                textStyle: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: displayWidth(context)*0.11,
                    fontWeight: FontWeight.w400),
                speed: const Duration(milliseconds: 50)),
          ],
        ),
      ),
      ),
    );
  }
}
