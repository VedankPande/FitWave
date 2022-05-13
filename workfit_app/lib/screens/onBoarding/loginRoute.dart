import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
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
                        textField(title: 'Username'),
                        textField(title: 'Set password'),
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
                    onPressed: () {
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
    //  Scaffold(
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         Text(
    //           "Login",
    //           style: TextStyle(
    //             color: Color(0xff232323),
    //             fontSize: 18,
    //             fontFamily: "Avenir",
    //             fontWeight: FontWeight.w800,
    //           ),
    //         ),
    //         Column(
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "Username",
    //               style: TextStyle(
    //                 color: Color(0xff9a9a9a),
    //                 fontSize: 16,
    //               ),
    //             ),
    //             SizedBox(height: 4),
    //             Container(
    //               width: 328,
    //               height: 48,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(3),
    //                 border: Border.all(
    //                   color: Color(0xffd5d5d5),
    //                   width: 1,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Column(
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "Set password",
    //               style: TextStyle(
    //                 color: Color(0xff9a9a9a),
    //                 fontSize: 16,
    //               ),
    //             ),
    //             SizedBox(height: 4),
    //             Container(
    //               width: 328,
    //               height: 48,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(3),
    //                 border: Border.all(
    //                   color: Color(0xffd5d5d5),
    //                   width: 1,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Container(
    //           width: 24,
    //           height: 24,
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(
    //                 width: 24,
    //                 height: 24,
    //                 padding: const EdgeInsets.only(
    //                   right: 1808,
    //                   bottom: 239,
    //                 ),
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Transform.rotate(
    //                       angle: 1.57,
    //                       child: Container(
    //                         width: 12.05,
    //                         height: double.infinity,
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(8),
    //                         ),
    //                         child: FlutterLogo(size: 12.048999786376953),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           width: 328,
    //           height: 50,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(3),
    //             gradient: LinearGradient(
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //               colors: [Color(0xff9066ea), Color(0xff6c4cb0)],
    //             ),
    //           ),
    //           padding: const EdgeInsets.only(
    //             left: 141,
    //             right: 140,
    //             top: 13,
    //             bottom: 12,
    //           ),
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Text(
    //                 "Login",
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 18,
    //                   fontFamily: "Avenir",
    //                   fontWeight: FontWeight.w800,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Text(
    //           "Don’t have an account?\nCreate account now",
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 16,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
