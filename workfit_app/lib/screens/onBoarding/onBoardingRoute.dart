import 'package:flutter/material.dart';
import 'package:workfit_app/screens/onBoarding/signup/signupRoute.dart';
import 'package:workfit_app/screens/workoutRoute.dart';
import 'package:workfit_app/widgets/coloredButton.dart';

import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/widgets/loginWidget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [LoginButton()],
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Image.asset(
                            'assets/images/on_boarding/on_boarding_1.png',
                          ),
                        ),
                        Container(
                          width: 328,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "ML based workout routines",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff232323),
                                  fontSize: 22,
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 328,
                                child: Text(
                                  "Workout smartly with our posture detection feature powered by Machine Learning",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff838383),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColoredButton(
                    buttonText: "Get Started",
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(microseconds: 500),
                          type: PageTransitionType.fade,
                          child: SignupScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
