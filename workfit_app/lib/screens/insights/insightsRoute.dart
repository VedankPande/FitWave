import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workfit_app/screens/diary/addFood.dart';
import 'package:workfit_app/services/api.dart';
import 'package:workfit_app/screens/workout/addNewSet/addNewSet.dart';
import 'package:workfit_app/services/userData.dart';
import 'package:workfit_app/widgets/caloriesGoalWidget.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({Key? key}) : super(key: key);

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
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
                              'Insights',
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
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 328,
                        height: 323,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x1e1b1b1b),
                              blurRadius: 20,
                              offset: Offset(0, 5),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Calorie Intake",
                              style: TextStyle(
                                color: Color(0xff232323),
                                fontSize: 18,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              width: 296,
                              height: 242,
                              child: Container(
                                width: 260.95,
                                height: 239,
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: LineChart(
                                    mainData(true),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 328,
                        height: 323,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x1e1b1b1b),
                              blurRadius: 20,
                              offset: Offset(0, 5),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Carbs Intake",
                              style: TextStyle(
                                color: Color(0xff232323),
                                fontSize: 18,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              width: 296,
                              height: 242,
                              child: Container(
                                width: 260.95,
                                height: 239,
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: LineChart(
                                    mainData(false),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
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

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff96a7af),
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('M', style: style);
      break;
    case 2:
      text = const Text('T', style: style);
      break;
    case 3:
      text = const Text('W', style: style);
      break;
    case 4:
      text = const Text('T', style: style);
      break;
    case 5:
      text = const Text('F', style: style);
      break;
    case 6:
      text = const Text('S', style: style);
      break;
    case 7:
      text = const Text('S', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 8.0,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff96a7af),
    fontSize: 12,
  );
  String text;
  log(value.toString());
  switch (value.toInt()) {
    case 1:
      text = '50g';
      break;
    case 2:
      text = '100g';
      break;
    case 3:
      text = '150g';
      break;
    case 4:
      text = '200g';
      break;
    case 5:
      text = '250g';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

LineChartData mainData(bool isCalories) {
  return LineChartData(
    backgroundColor: Colors.white,
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 30,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 1,
    maxX: 7,
    minY: 0,
    maxY: 5,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(1, 2.5),
          FlSpot(2, 1.6),
          FlSpot(3, 3),
          FlSpot(4, 2.6),
          FlSpot(5, 4.5),
          FlSpot(6, 4.4),
          FlSpot(7, 3.2),
        ],
        isCurved: true,
        color: isCalories ? Colors.purple : Colors.orange,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              isCalories ? Colors.purple : Colors.orange,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ],
  );
}
