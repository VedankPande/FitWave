import 'dart:convert';
import 'dart:developer' as logger;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:workfit_app/services/api.dart';
import 'package:workfit_app/services/authentication.dart';
import 'package:workfit_app/screens/home.dart';
import 'package:workfit_app/screens/onBoarding/onBoardingRoute.dart';
import 'package:workfit_app/services/userData.dart';
import 'package:workfit_app/screens/workout/workoutPostureRoute.dart';
import 'package:workfit_app/screens/workout/workoutSetsRoute.dart';
import 'package:workfit_app/widgets/bodyStatsWidget.dart';
import 'package:workfit_app/widgets/caloriesGoalWidget.dart';
import 'package:workfit_app/widgets/image_selector.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'dart:math';
import 'package:quds_popup_menu/quds_popup_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var workouts = getUserData()['workouts'];
  num calories = 0;
  final String username = getUserData()['username'];
  String userInitials = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    final userFullName = getUserData()['fullName'].toString().split(' ');
    try {
      userInitials += userFullName[0][0].toUpperCase();
      if (userFullName.length > 1) {
        userInitials += userFullName[userFullName.length - 1][0].toUpperCase();
      }
    } catch (e) {
      logger.log(e.toString());
    }
  }

  fetchUserData() async {
    final workoutResponse = await RestApi().fetchWorkout();
    final intakeResponse = await RestApi().fetchIntakes();
    num numCalories = 0;
    for (final intake in intakeResponse) {
      try {
        final calorie =
            double.parse(intake['food_data']['calorie']) * intake['amount'];
        numCalories += calorie;
      } catch (e) {
        logger.log(e.toString());
      }
    }
    numCalories = int.parse(numCalories.toStringAsFixed(0));
    try {
      logger.log(numCalories.toString());
      setState(() {
        workouts = workoutResponse ?? [];
        calories = numCalories;
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
          child: const Text("View workout sets"),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                duration: const Duration(microseconds: 500),
                type: PageTransitionType.fade,
                child: const Home(
                  currentIndex: 3,
                ),
              ),
              (route) => false,
            );
          },
        ),
      );
    }
    return Column(children: cards);
  }

  List<QudsPopupMenuBase> getMenuItems() {
    return [
      QudsPopupMenuItem(
        title: Text(
          'Logout',
        ),
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
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
        title: Text(
          'posture detection',
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              duration: const Duration(microseconds: 500),
              type: PageTransitionType.fade,
              child: WorkoutPostureScreen(),
            ),
          );
        },
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
        title: Text(
          'tflite',
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              duration: const Duration(microseconds: 500),
              type: PageTransitionType.fade,
              child: ImageSelector(),
            ),
            (route) => false,
          );
        },
      ),
    ];
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
                      QudsPopupButton(
                        // backgroundColor: Colors.red,
                        tooltip: username,
                        items: getMenuItems(),
                        child: Container(
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
                      CaloriesGoalWidget(
                        calorieConsumed: calories.toInt(),
                        calorieGoal: 2030,
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
