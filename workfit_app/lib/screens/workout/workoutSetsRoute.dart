import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/services/api.dart';
import 'package:workfit_app/screens/workout/addNewSet/addNewSet.dart';
import 'package:workfit_app/services/userData.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';
import 'package:http/http.dart' as http;

class WorkoutSetsScreen extends StatefulWidget {
  const WorkoutSetsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutSetsScreen> createState() => _WorkoutSetsScreenState();
}

class _WorkoutSetsScreenState extends State<WorkoutSetsScreen> {
  var workouts = getUserData()['workouts'];

  @override
  void initState() {
    super.initState();
    getWorkouts();
  }

  getWorkouts() async {
    var response = await RestApi().fetchWorkout();
    try {
      setState(() {
        workouts = response ?? [];
      });
    } catch (exc) {
      log(exc.toString());
    }
  }

  buildCards() {
    List<Widget> cards = [];
    for (var i = 0; i < workouts.length; i++) {
      var exercise = jsonDecode(jsonEncode(workouts[i]['workout_exercises']));
      var count = exercise?.length;

      cards.add(
        WorkoutCard(
          title: workouts[i]['name'].toString(),
          count: count != null ? count : 0,
          exercise: exercise,
        ),
      );
    }
    return Column(children: cards);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Workout Sets',
                    style: TextStyle(
                      color: Color(0xff232323),
                      fontSize: 20,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(microseconds: 500),
                          type: PageTransitionType.fade,
                          child: AddNewSetScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "+Add new set",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff9066ea),
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.797,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildCards(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
