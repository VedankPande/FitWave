import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/onBoarding/signup/signupRoute.dart';

class BorderButton extends StatefulWidget {
  final String buttonText;
  final Function onPressed;
  const BorderButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  State<BorderButton> createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.925,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Color(0xff9066ea)),
        ),
        padding: const EdgeInsets.only(
          top: 13,
          bottom: 12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff9066ea),
                fontSize: 18,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
