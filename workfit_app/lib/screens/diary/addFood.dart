import 'dart:developer';

import 'package:flutter/material.dart ';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/diary/mealDetails.dart';
import 'package:workfit_app/screens/onBoarding/signup/bodyDetails.dart';
import 'package:workfit_app/widgets/coloredButton.dart';
import 'package:workfit_app/widgets/loginWidget.dart';
import 'package:workfit_app/widgets/textFieldWidget.dart';
import 'package:workfit_app/services/api.dart';

class AddFoodScreen extends StatefulWidget {
  final String title;
  const AddFoodScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  List<Widget> foodWidgets = [];
  @override
  void initState() {
    super.initState();
    fetchFood();
  }

  fetchFood() async {
    List foodList = await RestApi().fetchFoods();
    List<Widget> listWidgets = [];
    log(foodList.length.toString());
    for (final food in foodList.sublist(0, 5)) {
      log('hello');
      listWidgets.add(
        foodCard(
          context,
          food['name'],
          "1 serving",
          food['calorie'],
          widget.title,
          food['carbohydrate'],
          food['protein'],
          food['fat'],
        ),
      );
    }
    log(listWidgets.toString());
    setState(() {
      foodWidgets = listWidgets;
    });
  }

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
                        widget.title,
                        style: TextStyle(
                          color: Color(0xff232323),
                          fontSize: 20,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Color(0xff9a9a9a),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/search.png',
                              ),
                              // child: FlutterLogo(size: 18),
                            ),
                            SizedBox(width: 16),
                            Text(
                              "Search for a food",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff9a9a9a),
                                fontSize: 16,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                          "Previously added",
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
                  Column(
                    children: foodWidgets,
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

foodCard(
  BuildContext context,
  title,
  servings,
  calories,
  meal,
  carbs,
  protein,
  fat,
) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        PageTransition(
          duration: Duration(microseconds: 500),
          type: PageTransitionType.fade,
          child: MealDetailsScreen(
            meal: meal,
            food: title,
            calories: calories,
            carbs: carbs,
            protein: protein,
            fat: fat,
          ),
        ),
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xfff8f8f8),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff232323),
                    fontSize: 16,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "${double.parse(calories).toStringAsFixed(0)} Kcal",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff9a9a9a),
                    fontSize: 14,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(
            servings,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff9a9a9a),
              fontSize: 14,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
