import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
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
    Container(
      height: 200,
      width: 200,
      child: Center(
        child: Text('Diary Not Implemented!'),
      ),
    ),
    Container(
      child: SafeArea(
        child: LineChart(mainData()),
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

LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
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
          // getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          // getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    ],
  );
}
