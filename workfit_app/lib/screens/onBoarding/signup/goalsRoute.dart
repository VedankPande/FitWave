import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/home.dart';
import 'package:workfit_app/screens/services/authentication.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final LocalStorage storage = new LocalStorage('fitwave');
  String selected = "Lose weight";
  goalCard(heading, body, image) {
    bool isSelected = selected == heading;
    return Container(
      margin: EdgeInsets.only(top: 30),
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSelected
              ? [Color(0xff9066ea), Color(0xff6c4cb0)]
              : [Colors.white, Colors.white],
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.zero, // Set this
          padding: EdgeInsets.zero, // and this
        ),
        onPressed: () {
          setState(() {
            selected = heading;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xff232323),
                      fontSize: 18,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    body,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xff757575),
                      fontSize: 16,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 21.25,
                      height: 21.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/goals/' + image,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                          "What is your goal?",
                          style: TextStyle(
                            color: Color(0xff232323),
                            fontSize: 18,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        goalCard(
                          "Lose weight",
                          "Burn fat & get lean",
                          'lose_weight.png',
                        ),
                        goalCard(
                          "Get Fitter",
                          "Tone up, get healthy and stay fit",
                          'get_fitter.png',
                        ),
                        goalCard(
                          "Gain Muscle",
                          "Build mass & strength",
                          'gain_muscle.png',
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
                  ColoredButton(
                    buttonText: "Save Details",
                    onPressed: () {
                      final ref = AuthenticationHelper().ref;
                      ref.child('goal').set(selected);
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            duration: Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: Home(),
                          ),
                          (route) => false);
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
