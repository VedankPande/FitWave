import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  var isNavMenuVisible = false;

  toggleVisibility() {
    setState(() {
      isNavMenuVisible = !isNavMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/sample_exercise.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: toggleVisibility,
                child: Image.asset('assets/images/menu.png'),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: null,
              child: Text('Squats'),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Visibility(
              visible: isNavMenuVisible,
              child: Container(
                width: MediaQuery.of(context).size.width / 10 * 8,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          ElevatedButton(
                            child: Text('X'),
                            onPressed: toggleVisibility,
                          ),
                          Text('Daily workout set-3'),
                          Text('Exercises'),
                          Text('Squats'),
                          Text('Push-ups'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: Text('End set'),
                      onPressed: null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
