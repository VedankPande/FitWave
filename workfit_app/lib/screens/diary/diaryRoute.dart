import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/diary/addFood.dart';
import 'package:workfit_app/services/api.dart';
import 'package:workfit_app/screens/workout/addNewSet/addNewSet.dart';
import 'package:workfit_app/services/userData.dart';
import 'package:workfit_app/widgets/caloriesGoalWidget.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  num calories = 0;
  var intakeList = [];
  var breakfastList = [];
  var lunchList = [];
  var dinnerList = [];
  var snacksList = [];

  @override
  void initState() {
    super.initState();
    intakeList = getUserData()['intakes'];
    fetchUserData();
    calculateMealData(intakeList);
  }

  fetchUserData() async {
    final intakeResponse = await RestApi().fetchIntakes();
    calculateMealData(intakeResponse);
  }

  calculateMealData(intakeResponse) {
    log(intakeResponse.length.toString());
    num numCalories = 0;
    List breakfastResponse = [];
    List lunchResponse = [];
    List dinnerResponse = [];
    List snacksResponse = [];
    for (final intake in intakeResponse) {
      try {
        final calorie =
            double.parse(intake['food_data']['calorie']) * intake['amount'];
        numCalories += calorie;
      } catch (e) {
        log(e.toString());
      }
      try {
        final category = intake['meal'];
        if (category == 'BR') {
          breakfastResponse.add(intake);
        } else if (category == 'LU') {
          lunchResponse.add(intake);
        } else if (category == 'DI') {
          dinnerResponse.add(intake);
        } else if (category == 'SN') {
          snacksResponse.add(intake);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    numCalories = int.parse(numCalories.toStringAsFixed(0));
    try {
      intakeList = intakeResponse;
      setState(() {
        calories = numCalories;
        breakfastList = breakfastResponse;
        lunchList = lunchResponse;
        dinnerList = dinnerResponse;
        snacksList = snacksResponse;
      });
    } catch (exc) {
      log(exc.toString());
    }
    log('end ${intakeResponse.length.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                color: Color(0xfff8f8f8),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Calorie Tracker',
                              style: TextStyle(
                                color: Color(0xff232323),
                                fontSize: 20,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            null;
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.angleLeft,
                            color: Color(0x7f7f3a44),
                          ),
                        ),
                        Text(
                          "July 1, 2022",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff757575),
                            fontSize: 16,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            null;
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: Color(0x7f7f3a44),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.775,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: CaloriesGoalWidget(
                          calorieConsumed: calories.toInt(),
                          calorieGoal: 2030,
                        ),
                      ),
                      diaryCard(
                        context,
                        'assets/images/diary/breakfast.png',
                        "Breakfast",
                        breakfastList,
                      ),
                      diaryCard(
                        context,
                        'assets/images/diary/lunch.png',
                        "Lunch",
                        lunchList,
                      ),
                      diaryCard(
                        context,
                        'assets/images/diary/dinner.png',
                        "Dinner",
                        dinnerList,
                      ),
                      diaryCard(
                        context,
                        'assets/images/diary/snacks.png',
                        "Snacks",
                        snacksList,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

buildIntakeMeals(context, List children) {
  List<Widget> listWidgets = [];

  if (children.length != 0) {
    listWidgets.add(
      Container(
        height: 1,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffF0F0F0),
      ),
    );
  }

  for (final child in children) {
    listWidgets.add(Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xfff8f8f8),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child['food_data']['name'],
                  style: TextStyle(
                    color: Color(0xff757575),
                    fontSize: 14,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "${double.parse(child['food_data']['calorie']).toStringAsFixed(0)} Kcal",
                  style: TextStyle(
                    color: Color(0xff757575),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "${child['amount']} serving",
            style: TextStyle(
              color: Color(0xff757575),
              fontSize: 14,
            ),
          ),
        ],
      ),
    ));
  }

  return listWidgets;
}

diaryCard(
  BuildContext context,
  String icon,
  String title,
  List children,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    color: Color(0xfff8f8f8),
    margin: EdgeInsets.only(bottom: 10),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: 22,
              ),
              SizedBox(width: 12),
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
            ],
          ),
        ),
        Column(
          children: buildIntakeMeals(context, children),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffF0F0F0),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(microseconds: 500),
                  type: PageTransitionType.fade,
                  child: AddFoodScreen(
                    title: title,
                  ),
                ),
              );
            },
            child: Text(
              "+ Add Food",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff2f7ec7),
                fontSize: 14,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
