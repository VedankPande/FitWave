import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/authentication.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                      var res = await AuthenticationHelper().signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
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
