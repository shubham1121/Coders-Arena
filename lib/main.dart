import 'package:coders_arena/controller/add_post_screen_controller.dart';
import 'package:coders_arena/controller/authentication_screen_controller.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/controller/verify_email_screen_controller.dart';
import 'package:coders_arena/services/firebase_services/firebase_auth.dart';
import 'package:coders_arena/services/firebase_services/firebase_user_service.dart';
import 'package:coders_arena/utils/wrapper.dart';
import 'package:coders_arena/view/screens/authentication/authentication_screen.dart';
import 'package:coders_arena/view/screens/feed/all_upload_images_view.dart';
import 'package:coders_arena/view/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load();
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
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddPostScreenController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/appRoot': (context) => const AppRoot(),
          '/authScreen': (context) => const AuthenticationScreen(),
          '/homeScreen': (context) => const HomeScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: const AppRoot(),
      ),
    );
  }
}
