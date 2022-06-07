import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:workfit_app/screens/onBoarding/signup/signupRoute.dart';
import 'package:workfit_app/screens/workout/workoutPostureRoute.dart';
import 'package:workfit_app/widgets/coloredButton.dart';

import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/widgets/loginWidget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [LoginButton()],
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 400,
                          autoPlay: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: [
                          [
                            'assets/images/on_boarding/on_boarding_1.png',
                            "ML based workout routines",
                            "Workout smartly with our posture detection feature powered by Machine Learning",
                          ],
                          [
                            'assets/images/on_boarding/on_boarding_2.png',
                            "Stay fit at home",
                            "We are here to keep you active from the comfort of your home.",
                          ],
                          [
                            'assets/images/on_boarding/on_boarding_3.png',
                            "The future of health is here",
                            "Plan & pair your exercise routines with FitWave and lead a healthy lifestyle.",
                          ],
                        ].map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.1,
                                      ),
                                      child: Image.asset(
                                        item[0],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item[1],
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
                                              item[2],
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
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: 59,
                  height: 9,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [0, 1, 2].map((item) {
                      return Container(
                        width: 9,
                        height: 9,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: _current == item
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(32.50),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff9066ea),
                                    Color(0xff6c4cb0)
                                  ],
                                ),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(32.50),
                                color: Color(0xffd5d5d5),
                              ),
                      );
                    }).toList(),
                  ),
                ),
              ],
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
