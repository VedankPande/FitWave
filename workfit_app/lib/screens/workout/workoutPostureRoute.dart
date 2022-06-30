import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workfit_app/widgets/postureWidget.dart';

class WorkoutPostureScreen extends StatefulWidget {
  final title;
  final exercises;
  const WorkoutPostureScreen(this.title, this.exercises, {Key? key})
      : super(key: key);

  @override
  State<WorkoutPostureScreen> createState() => _WorkoutPostureScreenState();
}

class _WorkoutPostureScreenState extends State<WorkoutPostureScreen> {
  var isNavMenuVisible = false;

  toggleVisibility() {
    setState(() {
      isNavMenuVisible = !isNavMenuVisible;
    });
  }

  Widget exerciseCard(title, {isActive = false}) {
    return isActive
        ? Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xfff8f8f8),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xff232323),
                    fontSize: 18,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 300,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xff9a9a9a),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
  }

  List<Widget> buildExercises() {
    List<Widget> response = [];
    if (widget.exercises.length > 0) {
      response.add(exerciseCard(
        widget.exercises[0]['exercise_data']['name'].toString(),
        isActive: true,
      ));
    }
    for (var i = 1; i < widget.exercises.length; i++) {
      response.add(exerciseCard(
          widget.exercises[i]['exercise_data']['name'].toString()));
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Center(
            //   child: Image.asset(
            //     'assets/images/sample_exercise.jpeg',
            //     fit: BoxFit.fill,
            //     height: MediaQuery.of(context).size.height * 0.5,
            //     width: MediaQuery.of(context).size.width,
            //   ),
            // ),
            PostureWidget(
              widget.exercises[0]['exercise_data']['name'].toString(),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: toggleVisibility,
                  child: Image.asset('assets/images/menu.png'),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xccffffff),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 108,
                        vertical: 15,
                      ),
                      child: Text(
                        widget.exercises[0]['exercise_data']['name'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff232323),
                          fontSize: 20,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Visibility(
                visible: isNavMenuVisible,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10 * 8,
                        height: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).viewPadding.top,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.title,
                                        style: TextStyle(
                                          color: Color(0xff6c4cb0),
                                          fontSize: 20,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: TextButton(
                                          onPressed: toggleVisibility,
                                          child: Text(
                                            'X',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xff232323),
                                              fontSize: 20,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 300,
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Exercises",
                                        style: TextStyle(
                                          color: Color(0xff232323),
                                          fontSize: 16,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Column(children: buildExercises()),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(bottom: 20),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "End Set",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xffe34c4c),
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
