import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/authentication.dart';
import 'package:workfit_app/screens/home.dart';
import 'package:workfit_app/screens/onBoarding/signup/goalsRoute.dart';
import 'package:workfit_app/screens/onBoarding/signup/signupRoute.dart';
import 'package:workfit_app/widgets/borderButton.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _BodyDetailsScreenState();
}

class _BodyDetailsScreenState extends State<LoginScreen> {
  final LocalStorage storage = new LocalStorage('fitwave');

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
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
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xff232323),
                            fontSize: 18,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        textField(
                          title: 'Username',
                          controller: emailController,
                        ),
                        textField(
                          title: 'Set password',
                          controller: passwordController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColoredButton(
                    buttonText: "Login",
                    onPressed: () async {
                      var res = await AuthenticationHelper().signIn(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (res == null) {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: Home(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(msg: res.toString());
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Don’t have an account?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              height: 30,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(microseconds: 500),
                      type: PageTransitionType.fade,
                      child: SignupScreen(),
                    ),
                  );
                },
                child: Text(
                  "Create account now",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 0,
                    color: Color(0xff9066ea),
                    fontSize: 16,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
