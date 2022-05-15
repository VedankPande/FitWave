import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/screens/services/api.dart';
import 'package:workfit_app/screens/workout/addNewSet/addNewSetExercise.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class AddNewSetCategoryScreen extends StatefulWidget {
  const AddNewSetCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddNewSetCategoryScreen> createState() =>
      _AddNewSetCategoryScreenState();
}

class _AddNewSetCategoryScreenState extends State<AddNewSetCategoryScreen> {
  var exercisesObj = {};

  @override
  void initState() {
    getExercises();
  }

  getExercises() async {
    var response = await RestApi().fetchExercises();
    var responseObj = {};

    for (var i = 0; i < response.length; i++) {
      if (responseObj[response[i]['muscles_worked']] != null) {
        responseObj[response[i]['muscles_worked']].add(response[i]);
      } else {
        responseObj[response[i]['muscles_worked']] = [];
      }
    }

    setState(() {
      exercisesObj = responseObj;
    });
  }

  cardWidget(String title, exercises) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(microseconds: 500),
            type: PageTransitionType.fade,
            child: AddNewSetExerciseScreen(
              exercise: title,
              exercises: exercises,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 88,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff232323),
                fontSize: 20,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildCards() {
    List<Widget> cards = [];
    log(exercisesObj.toString());
    exercisesObj.forEach((key, value) {
      cards.add(
        cardWidget(key, value),
      );
    });
    List<Widget> rows = [];

    for (var i = 1; i < cards.length; i += 2) {
      rows.add(
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cards[i - 1],
            cards[i],
          ],
        ),
      );
    }

    if (cards.length % 2 != 0) {
      rows.add(
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cards[cards.length - 1],
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
            ),
          ],
        ),
      );
    }

    return Column(children: rows);
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
                        "Add Exercises",
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Color(0xff9a9a9a),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/search.png',
                              ),
                              // child: FlutterLogo(size: 18),
                            ),
                            SizedBox(width: 16),
                            Text(
                              "Search exercises",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff9a9a9a),
                                fontSize: 16,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.74,
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
