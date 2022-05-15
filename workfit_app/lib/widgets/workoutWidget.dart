import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/workout/viewSet.dart';
import 'package:workfit_app/screens/workout/workoutPostureRoute.dart';

class WorkoutCard extends StatefulWidget {
  final String title;
  final int count;
  final exercise;
  const WorkoutCard({
    required this.title,
    required this.count,
    required this.exercise,
  });

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 139,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 107,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Workout schedule",
                            style: TextStyle(
                              color: Color(0xff9a9a9a),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Color(0xff6c4cb0),
                        fontSize: 18,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.count.toString() + " exercises",
                        style: TextStyle(
                          color: Color(0xff232323),
                          fontSize: 16,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 118),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(microseconds: 500),
                              type: PageTransitionType.fade,
                              child: ViewSetScreen(
                                title: widget.title,
                                exercise: widget.exercise,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 94,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Color(0xff6c4cb0),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f9a9a9a),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 13,
                            top: 7,
                            bottom: 6,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "View",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff6c4cb0),
                                  fontSize: 15.56,
                                ),
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
          ),
        ],
      ),
    );
  }
}
