import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/loginRoute.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(microseconds: 500),
            type: PageTransitionType.fade,
            child: LoginScreen(),
          ),
        );
      },
      child: Text(
        "Login",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xff9066ea),
          fontSize: 16,
          fontFamily: "Avenir",
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
