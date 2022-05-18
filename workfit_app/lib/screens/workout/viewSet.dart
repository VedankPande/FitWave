import 'dart:developer';

import 'package:flutter/material.dart ';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
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
  card(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
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
    );
  }

  buildExercises() {
    List<Widget> exercises = [];
    log('asdf' + widget.exercise.toString());
    for (var i = 0; i < widget.exercise.length; i++) {
      final title = widget.exercise[i]['exercise_data']['name'];
      exercises.add(card(title));
    }
    return Column(children: exercises);
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
      ),
    );
  }
}
