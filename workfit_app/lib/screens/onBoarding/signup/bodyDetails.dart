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
  final genderController = TextEditingController();
  final activityController = TextEditingController();

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
                        textField(
                          title: 'Gender',
                          controller: genderController,
                        ),
                        textField(
                          title: 'Activity',
                          controller: activityController,
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
                      final gender = genderController.text;
                      final activity = activityController.text;

                      final ref = AuthenticationHelper().ref;
                      await ref.child('age').set(age);
                      await ref.child('height').set(height);
                      await ref.child('weight').set(weight);
                      await ref.child('gender').set(gender);
                      await ref.child('activity').set(activity);

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
