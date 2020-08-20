import 'package:flutter/material.dart';
import 'package:forte/screens/Home.dart';
import 'package:forte/screens/SplashScreen.dart';
import 'package:forte/screens/login.dart';
import 'package:forte/screens/sign_up.dart';
import 'screens/on_boarding_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Forte Laundry",
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      theme: ThemeData(
        fontFamily: "Berlin Bold",
      ),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        SplashScreen.id: (context) => SplashScreen(),
        SignUp.id: (context) => SignUp(),
        OnboardingScreen.id: (context) => OnboardingScreen(),
        Home.id: (context) => Home(),
      },
    );
  }
}
