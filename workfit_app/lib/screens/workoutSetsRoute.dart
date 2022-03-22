import 'package:flutter/material.dart';
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Workout Sets'),
              TextButton(
                onPressed: null,
                child: Text('+ Add new set'),
              )
            ],
          ),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
        ],
      ),
    );
  }
}
