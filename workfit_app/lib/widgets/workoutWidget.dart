import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/workoutRoute.dart';

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({Key? key}) : super(key: key);

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.green, spreadRadius: 8),
          BoxShadow(color: Colors.yellow, spreadRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Schedule"),
              Text('Wed, 21/11/2021'),
            ],
          ),
          Text('Daily workout set-3'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/running_man.png'),
                  Text('6 exercises'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(microseconds: 500),
                      type: PageTransitionType.fade,
                      child: WorkoutScreen(),
                    ),
                  );
                },
                child: Text('Start now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
