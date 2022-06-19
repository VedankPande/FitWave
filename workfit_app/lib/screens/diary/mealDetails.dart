import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workfit_app/widgets/coloredButton.dart';

class MealDetailsScreen extends StatefulWidget {
  final String meal;
  final String food;
  const MealDetailsScreen({
    Key? key,
    required this.meal,
    required this.food,
  }) : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final mealDropdownItems = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  String mealDropdownValue = '';
  final servingsDropdownItems = ['1', '2', '3', '4'];
  String servingsDropdownValue = '1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mealDropdownValue == '') {
      mealDropdownValue = widget.meal;
    }
  }

  final workoutNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 7),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: FaIcon(FontAwesomeIcons.arrowLeftLong),
                      ),
                      Text(
                        'Add food',
                        style: TextStyle(
                          color: Color(0xff232323),
                          fontSize: 20,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  widget.food,
                                  style: TextStyle(
                                    color: Color(0xff232323),
                                    fontSize: 18,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Meal",
                                      style: TextStyle(
                                        color: Color(0xff9a9a9a),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                          color: Color(0xffd5d5d5),
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: mealDropdownValue,
                                        items: mealDropdownItems.map(
                                          (String items) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                items,
                                                style: TextStyle(
                                                  color: Color(0xff232323),
                                                  fontSize: 16,
                                                  fontFamily: "Avenir",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              value: items,
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            mealDropdownValue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Number of servings (cups/pieces/bowl)",
                                      style: TextStyle(
                                        color: Color(0xff9a9a9a),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                          color: Color(0xffd5d5d5),
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: servingsDropdownValue,
                                        items: servingsDropdownItems.map(
                                          (String items) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                items,
                                                style: TextStyle(
                                                  color: Color(0xff232323),
                                                  fontSize: 16,
                                                  fontFamily: "Avenir",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              value: items,
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            servingsDropdownValue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Nutrition Breakdown",
                                style: TextStyle(
                                  color: Color(0xff232323),
                                  fontSize: 16,
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  nutritionCard(
                                    context,
                                    'assets/images/nutrition/calories.png',
                                    "Calories",
                                    '290',
                                  ),
                                  nutritionCard(
                                    context,
                                    'assets/images/nutrition/carbs.png',
                                    "Carbs",
                                    '10g',
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  nutritionCard(
                                    context,
                                    'assets/images/nutrition/protein.png',
                                    "Protein",
                                    '25g',
                                  ),
                                  nutritionCard(
                                    context,
                                    'assets/images/nutrition/fat.png',
                                    "Fat",
                                    '12g',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ColoredButton(
                buttonText: 'Confirm food',
                onPressed: () {
                  null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

nutritionCard(BuildContext context, icon, title, value) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.43,
    padding: EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 25,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: Color(0xfff0f0f0),
        width: 1,
      ),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Padding(
          child: Image.asset(
            icon,
            height: 30,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
        ),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 14,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Color(0xff232323),
                fontSize: 20,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
