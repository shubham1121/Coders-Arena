import 'package:coders_arena/controller/authentication_screen_controller.dart';
import 'package:coders_arena/controller/verify_email_screen_controller.dart';
import 'package:coders_arena/services/firebase_auth.dart';
import 'package:coders_arena/services/firebase_user_service.dart';
import 'package:coders_arena/utils/wrapper.dart';
import 'package:coders_arena/view/screens/authentication_screen.dart';
import 'package:coders_arena/view/screens/home_screen.dart';
import 'package:coders_arena/view/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        // Auth Providers
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChange,
          initialData: null,
        ),

        // Screen Controller Providers
        ChangeNotifierProvider(
          create: (context) => AuthScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerifyEmailScreenController(),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
          routes: {
            '/AppRoot': (context) => const AppRoot(),
            '/authScreen': (context) => const AuthenticationScreen(),
            '/homeScreen': (context) => const HomeScreen(),
          },
        home: const SplashScreen(),
      ),
    );
  }
}
