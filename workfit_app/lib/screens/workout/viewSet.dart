import 'dart:developer';

import 'package:flutter/material.dart ';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/screens/workout/workoutPostureRoute.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class ViewSetScreen extends StatefulWidget {
  final String title;
  final exercise;
  const ViewSetScreen({
    required this.title,
    required this.exercise,
  });

  @override
  State<ViewSetScreen> createState() => _ViewSetScreenState();
}

class _ViewSetScreenState extends State<ViewSetScreen> {
  card(String title, String sets, String reps) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xff232323),
                  fontSize: 16,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$sets Reps",
                    style: TextStyle(
                      color: Color(0xff9a9a9a),
                      fontSize: 12,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "|",
                    style: TextStyle(
                      color: Color(0xff9a9a9a),
                      fontSize: 12,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "$reps Sets",
                    style: TextStyle(
                      color: Color(0xff9a9a9a),
                      fontSize: 12,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildExercises() {
    List<Widget> exercises = [];
    log('asdf' + widget.exercise.toString());
    for (var i = 0; i < widget.exercise.length; i++) {
      final String title =
          widget.exercise[i]['exercise_data']['name'].toString();
      final String sets = widget.exercise[i]['sets'].toString();
      final String reps = widget.exercise[i]['reps'].toString();
      exercises.add(card(title, sets, reps));
    }
    return Column(children: exercises);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: FaIcon(FontAwesomeIcons.arrowLeftLong),
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Color(0xff232323),
                              fontSize: 20,
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xfff8f8f8),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Exercises",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff232323),
                                fontSize: 16,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildExercises(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: ColoredButton(
                  buttonText: 'Start now',
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(microseconds: 500),
                        type: PageTransitionType.fade,
                        child:
                            WorkoutPostureScreen(widget.title, widget.exercise),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
