import 'package:flutter/material.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/homeRoute.dart';

class SplashScreen extends StatefulWidget {
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
    Timer(Duration(seconds: 3), nextScreen);
  }

  nextScreen() async {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          duration: Duration(microseconds: 500),
          type: PageTransitionType.fade,
          child: HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Pande chutiya!'),
      ),
    );
  }
}
