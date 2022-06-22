import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class CaloriesGoalWidget extends StatefulWidget {
  final int calorieConsumed;
  final int calorieGoal;
  const CaloriesGoalWidget({
    required this.calorieConsumed,
    required this.calorieGoal,
  });

  @override
  State<CaloriesGoalWidget> createState() => _CaloriesGoalWidgetState();
}

class _CaloriesGoalWidgetState extends State<CaloriesGoalWidget> {
  late ValueNotifier<double> valueNotifier;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(0.0);
  }

  @override
  Widget build(BuildContext context) {
    valueNotifier.value = double.parse(
      ((widget.calorieConsumed / widget.calorieGoal) * 100).toStringAsFixed(0),
    );
    return Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.calorieConsumed.toString(),
                          style: TextStyle(
                            color: Color(0xff232323),
                            fontSize: 20,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          " /${widget.calorieGoal.toString()} Kcal",
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
                progressColors: [Color(0xff9066ea), Color(0xff6c4cb0)],
                backColor: Color(0xffD6D6D6),
                animationDuration: 2,
                mergeMode: true,
                valueNotifier: valueNotifier,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  (widget.calorieGoal - widget.calorieConsumed)
                                      .toString(),
                                  style: TextStyle(
                                    color: Color(0xff232323),
                                    fontSize: 20,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w800,
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
    );
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }
}
