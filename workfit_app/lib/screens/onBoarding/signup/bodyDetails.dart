import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/goalsRoute.dart';
import 'package:workfit_app/screens/onBoarding/loginRoute.dart';
import 'package:workfit_app/services/authentication.dart';
import 'package:workfit_app/widgets/borderButton.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class BodyDetailsScreen extends StatefulWidget {
  const BodyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BodyDetailsScreen> createState() => _BodyDetailsScreenState();
}

class _BodyDetailsScreenState extends State<BodyDetailsScreen> {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final genderDropdownItems = ['Male', 'Female'];
  String genderDropdownValue = 'Male';
  final activityDropdownItems = [
    "Sedentary: little or no exercise",
    "Light: exercise 1-3 times/week",
    "Moderate: exercise 4-5 times/week",
    "Active: daily exercise or intense exercise 3-4 times/week",
    "Very active: intense exercise 6-7 times/week",
  ];
  String activityDropdownValue =
      "Active: daily exercise or intense exercise 3-4 times/week";

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: FaIcon(FontAwesomeIcons.arrowLeftLong),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Finish your Profile",
                          style: TextStyle(
                            color: Color(0xff232323),
                            fontSize: 18,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        textField(
                          title: 'Age',
                          controller: ageController,
                        ),
                        textField(
                          title: 'Height (in cm)',
                          controller: heightController,
                        ),
                        textField(
                          title: 'Weight (in Kg)',
                          controller: weightController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender",
                                style: TextStyle(
                                  color: Color(0xff9a9a9a),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: Color(0xffd5d5d5),
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: genderDropdownValue,
                                  items: genderDropdownItems.map(
                                    (String items) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          items,
                                          style: TextStyle(
                                            color: Color(0xff232323),
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        value: items,
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      genderDropdownValue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Activity",
                                style: TextStyle(
                                  color: Color(0xff9a9a9a),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: Color(0xffd5d5d5),
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                child: DropdownButton(
                                  isDense: true,
                                  isExpanded: true,
                                  value: activityDropdownValue,
                                  items: activityDropdownItems.map(
                                    (String items) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          items,
                                          style: TextStyle(
                                            color: Color(0xff232323),
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        value: items,
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      activityDropdownValue = newValue!;
                                    });
                                  },
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
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BorderButton(
                    buttonText: "Next",
                    onPressed: () async {
                      final age = ageController.text;
                      final height = heightController.text;
                      final weight = weightController.text;

                      final ref = AuthenticationHelper().ref;
                      await ref.child('age').set(int.parse(age));
                      await ref.child('height').set(double.parse(height));
                      await ref.child('weight').set(int.parse(weight));
                      await ref.child('gender').set(genderDropdownValue);
                      await ref.child('activity').set(activityDropdownValue);

                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(microseconds: 500),
                          type: PageTransitionType.fade,
                          child: GoalsScreen(),
                        ),
                      );
                    },
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
