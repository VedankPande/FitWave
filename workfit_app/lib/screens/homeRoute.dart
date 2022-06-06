import 'dart:convert';
import 'dart:developer' as logger;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:workfit_app/screens/services/api.dart';
import 'package:workfit_app/screens/services/authentication.dart';
import 'package:workfit_app/screens/home.dart';
import 'package:workfit_app/screens/onBoarding/onBoardingRoute.dart';
import 'package:workfit_app/screens/services/userdata.dart';
import 'package:workfit_app/screens/workout/workoutPostureRoute.dart';
import 'package:workfit_app/screens/workout/workoutSetsRoute.dart';
import 'package:workfit_app/widgets/bodyStatsWidget.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var workouts = [];
  final String username = getUserData()['username'];
  String userInitials = '';

  @override
  void initState() {
    super.initState();
    getWorkouts();
    final userFullName = getUserData()['fullName'].toString().split(' ');
    userInitials += userFullName[0][0].toUpperCase();
    if (userFullName.length > 1) {
      userInitials += userFullName[userFullName.length - 1][0].toUpperCase();
    }
  }

  getWorkouts() async {
    var response = await RestApi().fetchWorkout();
    try {
      setState(() {
        workouts = response;
      });
    } catch (exc) {
      logger.log(exc.toString());
    }
  }

  buildCards() {
    List<Widget> cards = [];
    if (workouts.length > 0) {
      var exercise = jsonDecode(
          jsonEncode(workouts[workouts.length - 1]['workout_exercises']));
      var count = exercise?.length;

      cards.add(
        WorkoutCard(
          title: workouts[workouts.length - 1]['name'].toString(),
          count: count != null ? count : 0,
          exercise: exercise,
        ),
      );
      cards.add(
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                duration: const Duration(microseconds: 500),
                type: PageTransitionType.fade,
                child: const Home(
                  currentIndex: 2,
                ),
              ),
              (route) => false,
            );
          },
          child: const Text("View workout sets"),
        ),
      );
    }
    return Column(children: cards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi! $username',
                        style: TextStyle(
                          color: Color(0xff232323),
                          fontSize: 20,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        child: Stack(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffe4d0ff),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  userInitials,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff232323),
                                    fontSize: 15.56,
                                    fontFamily: "Source Sans Pro",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      buildCards(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f9a9a9a),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Daily Calories Goal",
                                        style: TextStyle(
                                          color: Color(0xff9a9a9a),
                                          fontSize: 14,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            "1640",
                                            style: TextStyle(
                                              color: Color(0xff232323),
                                              fontSize: 20,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            " /2030 Kcal",
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SimpleCircularProgressBar(
                                  startAngle: 180,
                                  progressStrokeWidth: 6,
                                  backStrokeWidth: 6,
                                  progressColors: [
                                    Color(0xff9066ea),
                                    Color(0xff6c4cb0)
                                  ],
                                  backColor: Color(0xffD6D6D6),
                                  animationDuration: 2,
                                  mergeMode: true,
                                  valueNotifier: ValueNotifier(85),
                                ),
                                Container(
                                  width: 110,
                                  height: 110,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Remaining",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xff757575),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "390",
                                                    style: TextStyle(
                                                      color: Color(0xff232323),
                                                      fontSize: 20,
                                                      fontFamily: "Avenir",
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                  Text(
                                                    " Kcal",
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 301,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 175,
                              child: bodyStatisticsCard(
                                icon: 'body_statistics_bmi.png',
                                title: 'BMI',
                                body: (getUserData()['weight'] /
                                        pow(getUserData()['height'], 2))
                                    .toStringAsFixed(2),
                                footer: 'Updated: 1 month ago',
                                color: Color(0xffff7070),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Body Statistics",
                                  style: TextStyle(
                                    color: Color(0xff232323),
                                    fontSize: 18,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Edit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff9a9a9a),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 41,
                              child: bodyStatisticsCard(
                                icon: 'body_statistics_height.png',
                                title: 'Height',
                                body: '${getUserData()['height']} m',
                                footer: 'Updated: 1 month ago',
                                color: Color(0xff9066e9),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 41,
                              child: bodyStatisticsCard(
                                icon: 'body_statistics_weight.png',
                                title: 'Weight',
                                body: '${getUserData()['weight']} Kg',
                                footer: 'Updated: 1 month ago',
                                color: Color(0xff5dc57a),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AuthenticationHelper().signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              duration: const Duration(microseconds: 500),
                              type: PageTransitionType.fade,
                              child: OnBoarding(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Logout',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              duration: const Duration(microseconds: 500),
                              type: PageTransitionType.fade,
                              child: WorkoutPostureScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'posture detection',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
