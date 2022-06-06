import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/services/authentication.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fullNameController.dispose();
    userNameController.dispose();
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
                      ),
                      LoginButton()
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create your account",
                          style: TextStyle(
                            color: Color(0xff232323),
                            fontSize: 18,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        textField(
                          title: 'Full Name',
                          controller: fullNameController,
                        ),
                        textField(
                          title: 'Username',
                          controller: userNameController,
                        ),
                        textField(
                          title: 'Email ID',
                          controller: emailController,
                        ),
                        textField(
                          title: 'Set password',
                          controller: passwordController,
                          obscureText: true,
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
                    buttonText: "Create Account",
                    onPressed: () async {
                      final email = emailController.text;
                      final password = passwordController.text;
                      final fullName = fullNameController.text;
                      final username = userNameController.text;
                      var res = await AuthenticationHelper().signUp(
                        email: email,
                        password: password,
                      );
                      await AuthenticationHelper().ref.set({
                        "fullName": fullName,
                        "username": username,
                        "email": email,
                      });
                      if (res == null) {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: BodyDetailsScreen(),
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
          ],
        ),
      ),
    );
  }
}
