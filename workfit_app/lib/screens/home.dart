import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:workfit_app/screens/diary/diaryRoute.dart';
import 'package:workfit_app/screens/homeRoute.dart';
import 'package:workfit_app/screens/insights/insightsRoute.dart';
import 'package:workfit_app/screens/workout/workoutSetsRoute.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';

class Home extends StatefulWidget {
  final currentIndex;
  const Home({this.currentIndex = 0});

  @override
  State<Home> createState() => _HomeState();
}

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
    InsightsScreen(),
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
