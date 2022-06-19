import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:workfit_app/screens/diary/diaryRoute.dart';
import 'package:workfit_app/screens/homeRoute.dart';
import 'package:workfit_app/screens/workout/workoutSetsRoute.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';

class Home extends StatefulWidget {
  final currentIndex;
  const Home({this.currentIndex = 0});

  @override
  State<Home> createState() => _HomeState();
}

List<Color> gradientColors = [
  Colors.green,
  Colors.white,
];

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.currentIndex;
    });
  }

  final List<Widget> _children = [
    HomeScreen(),
    DiaryScreen(),
    Container(
      child: SafeArea(
        child: AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18.0,
                left: 12.0,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ),
    ),
    WorkoutSetsScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontFamily: "Avenir",
            fontWeight: FontWeight.w800,
            height: 2),
        unselectedLabelStyle: TextStyle(
          color: Color(0xff9a9a9a),
          fontSize: 12,
          fontFamily: "Avenir",
          fontWeight: FontWeight.w800,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/navBar/home_inactive.png',
              height: 25,
            ),
            activeIcon: Image.asset(
              'assets/images/navBar/home_active.png',
              height: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/navBar/diary_inactive.png',
              height: 25,
            ),
            activeIcon: Image.asset(
              'assets/images/navBar/diary_active.png',
              height: 25,
            ),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/navBar/chart_inactive.png',
              height: 25,
            ),
            activeIcon: Image.asset(
              'assets/images/navBar/chart_active.png',
              height: 25,
            ),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/navBar/fitness-center_inactive.png',
              height: 25,
            ),
            activeIcon: Image.asset(
              'assets/images/navBar/fitness-center_active.png',
              height: 25,
            ),
            label: 'Sets',
          ),
        ],
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('M', style: style);
      break;
    case 2:
      text = const Text('M', style: style);
      break;
    case 3:
      text = const Text('M', style: style);
      break;
    case 4:
      text = const Text('M', style: style);
      break;
    case 5:
      text = const Text('M', style: style);
      break;
    case 6:
      text = const Text('M', style: style);
      break;
    case 7:
      text = const Text('M', style: style);
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
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  log(value.toString());
  switch (value.toInt()) {
    case 1:
      text = '10K';
      break;
    case 2:
      text = '30k';
      break;
    case 6:
      text = '50k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

LineChartData mainData() {
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
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 62,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 1,
    maxX: 7,
    minY: 0,
    maxY: 10,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(1, 2),
          FlSpot(2, 1),
          FlSpot(3, 3),
          FlSpot(4, 2),
          FlSpot(5, 8),
          FlSpot(6, 6),
          FlSpot(7, 5),
        ],
        isCurved: true,
        color: Colors.green,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ],
  );
}
