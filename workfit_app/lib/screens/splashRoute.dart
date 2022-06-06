import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/services/authentication.dart';
import 'package:workfit_app/screens/home.dart';
import 'package:workfit_app/screens/onBoarding/onBoardingRoute.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    Timer(const Duration(seconds: 3), nextScreen);
  }

  nextScreen() async {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          duration: const Duration(microseconds: 500),
          type: PageTransitionType.fade,
          child: await AuthenticationHelper().handleAuth()
              ? const Home()
              : const OnBoarding(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 100,
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/images/fitwave_logo.png',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "FitWave",
            style: TextStyle(
              color: Color(0xff6c4cb0),
              fontSize: 32,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
