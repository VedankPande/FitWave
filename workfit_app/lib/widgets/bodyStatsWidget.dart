import 'package:flutter/material.dart';

class bodyStatisticsCard extends StatefulWidget {
  final icon, title, body, footer, color;
  bodyStatisticsCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.footer,
    required this.color,
  });

  @override
  State<bodyStatisticsCard> createState() => _bodyStatisticsCardState();
}

class _bodyStatisticsCardState extends State<bodyStatisticsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Color(0xfff0f0f0),
          width: 1,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'assets/images/' + widget.icon,
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 16,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.body,
                    style: TextStyle(
                      color: Color(0xff232323),
                      fontSize: 22,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
