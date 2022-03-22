import 'package:flutter/material.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

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
          child: const Home(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Pande chutiya!'),
      ),
    );
  }
}
