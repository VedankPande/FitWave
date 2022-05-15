import 'dart:developer';

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class AddNewSetExerciseScreen extends StatefulWidget {
  final String exercise;
  final exercises;
  const AddNewSetExerciseScreen({
    required this.exercise,
    required this.exercises,
  });

  @override
  State<AddNewSetExerciseScreen> createState() =>
      _AddNewSetExerciseScreenState();
}

class _AddNewSetExerciseScreenState extends State<AddNewSetExerciseScreen> {
  bool isChecked = false;

  card(String title) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
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
      cards.add(card(item['name']));
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
