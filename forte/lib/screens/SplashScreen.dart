import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:forte/screens/Home.dart';
import 'package:forte/screens/on_boarding_screens.dart';

import '../sharedPref.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 5), moveToAds);
  }

  void moveToAds() async {
    var themeText = await getAnyFromSharedPref('user');

    if (themeText != null && themeText.isNotEmpty) {
      await Navigator.pushReplacementNamed(context, Home.id);
    } else {
      await Navigator.pushReplacementNamed(context, OnboardingScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('images/logo.png', width: 200, height: 120),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('images/2650152.png', height: 300.0))
        ],
      ),
    );
  }
}
