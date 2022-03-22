import 'package:flutter/material.dart';
import 'package:workfit_app/screens/home.dart';
import 'package:workfit_app/screens/workoutSetsRoute.dart';
import 'package:workfit_app/widgets/bodyStatsWidget.dart';
import 'package:workfit_app/widgets/workoutWidget.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hi! Kaushik'),
                  Image.network(
                    'https://static.wikia.nocookie.net/rockstargamesgtavicecity/images/6/6a/Artwork-GTAVC-TommyVercetti.jpg/revision/latest/scale-to-width-down/180?cb=20160522093004',
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  const WorkoutCard(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          duration: const Duration(microseconds: 500),
                          type: PageTransitionType.fade,
                          child: const Home(
                            currentIndex: 2,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('View schedule'),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Body Statistics'),
                      Text('Edit'),
                    ],
                  ),
                  Row(
                    children: [
                      bodyStatisticsCard(
                        icon: 'body_statistics_height.png',
                        title: 'Height',
                        body: '5’ 4’’',
                        footer: 'Updated: 1 month ago',
                      ),
                      bodyStatisticsCard(
                        icon: 'body_statistics_weight.png',
                        title: 'Weight',
                        body: '60 Kg',
                        footer: 'Updated: 1 month ago',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      bodyStatisticsCard(
                        icon: 'body_statistics_bmi.png',
                        title: 'BMI',
                        body: '22.7',
                        footer: 'Updated: 1 month ago',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.green, spreadRadius: 8),
                  BoxShadow(color: Colors.yellow, spreadRadius: 5),
                ],
              ),
              child: Column(
                children: const [
                  Text('Kaushik, Create your personalized workout set'),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Create Set'),
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
