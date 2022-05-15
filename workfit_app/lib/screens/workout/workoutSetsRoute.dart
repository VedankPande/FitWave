import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/workout/addNewSet/addNewSet.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';

class WorkoutSetsScreen extends StatefulWidget {
  const WorkoutSetsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutSetsScreen> createState() => _WorkoutSetsScreenState();
}

class _WorkoutSetsScreenState extends State<WorkoutSetsScreen> {
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
                    "Workout Sets",
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
            const WorkoutCard(
              isCurrent: false,
            ),
            const WorkoutCard(
              isCurrent: true,
            ),
            const WorkoutCard(
              isCurrent: false,
            ),
          ],
        ),
      ),
    );
  }
}
