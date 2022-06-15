import 'dart:developer';

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/services/api.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class AddNewSetExerciseScreen extends StatefulWidget {
  final String exercise;
  final exercises;
  final workoutId;
  const AddNewSetExerciseScreen({
    required this.exercise,
    required this.exercises,
    required this.workoutId,
  });

  @override
  State<AddNewSetExerciseScreen> createState() =>
      _AddNewSetExerciseScreenState();
}

class _AddNewSetExerciseScreenState extends State<AddNewSetExerciseScreen> {
  Map<String, bool> checkboxMap = {};

  card(String title, id) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: checkboxMap[title],
          onChanged: (bool? value) {
            setState(() {
              checkboxMap[title] = value ?? false;
            });
            if (value ?? false) {
              RestApi().postExercise(widget.workoutId, id);
            }
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Color(0xff232323),
            fontSize: 16,
            fontFamily: "Avenir",
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  buildCards() {
    List<Widget> cards = [];
    for (var item in widget.exercises) {
      if (checkboxMap[item['name']] == null) {
        checkboxMap[item['name']] = false;
      }
      cards.add(card(item['name'], item['id']));
    }

    return Column(children: cards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        widget.exercise,
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
                    height: MediaQuery.of(context).size.height * 0.83,
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
          ],
        ),
      ),
    );
  }
}
