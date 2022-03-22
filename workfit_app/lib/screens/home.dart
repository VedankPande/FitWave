import 'package:flutter/material.dart';
import 'package:workfit_app/screens/homeRoute.dart';
import 'package:workfit_app/screens/workoutSetsRoute.dart';
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
    Container(
      child: Center(
        child: Text('Insignths Not Implemented!'),
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
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottom_navbar_home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottom_navbar_chart.png'),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottom_navbar_fitness-center.png'),
            label: 'Workout sets',
          ),
        ],
      ),
    );
  }
}
