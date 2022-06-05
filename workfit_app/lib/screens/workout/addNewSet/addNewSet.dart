import 'package:flutter/material.dart ';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/screens/workout/addNewSet/addNewSetCategory.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';
import 'package:workfit_app/screens/services/api.dart';

class AddNewSetScreen extends StatefulWidget {
  const AddNewSetScreen({Key? key}) : super(key: key);

  @override
  State<AddNewSetScreen> createState() => _AddNewSetScreenState();
}

class _AddNewSetScreenState extends State<AddNewSetScreen> {
  final workoutNameController = TextEditingController();
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
                        "Add new set",
                        style: TextStyle(
                          color: Color(0xff232323),
                          fontSize: 20,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: textField(
                      title: 'Workout set name',
                      controller: workoutNameController,
                    ),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xfff0f0f0),
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            RestApi().postWorkoutSet(
                              workoutNameController.text,
                            );
                            Navigator.push(
                              context,
                              PageTransition(
                                duration: Duration(microseconds: 500),
                                type: PageTransitionType.fade,
                                child: AddNewSetCategoryScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "+Add exercises",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff2f7ec7),
                              fontSize: 16,
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w800,
                            ),
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
    );
  }
}
