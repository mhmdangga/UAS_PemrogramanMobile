import 'package:firebase_core/firebase_core.dart';
import 'package:fix/firebase_options.dart';
import 'package:fix/src/screen/splash_screen.dart';
import 'package:fix/src/widgets/bio.dart';
import 'package:fix/src/widgets/card_view.dart';
import 'package:fix/src/widgets/forgot_password.dart';
import 'package:fix/src/widgets/homepage.dart';
import 'package:fix/src/widgets/introduction.dart';
import 'package:fix/src/widgets/login_page.dart';
import 'package:fix/src/widgets/mountain_pages.dart';
import 'package:fix/src/widgets/register_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// DefaultFirebaseOptions
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/intro': (context) => IntroPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homepage': (context) => HomePage(),
        '/forgotpw': (context) => ForgotPasswordPage(),
        '/mountain': (context) => MountainPages(),
        '/cardview': (context) => MyCardView(),
        '/bio': (context) => UserProfilePage(),
      },
    );
  }
}
