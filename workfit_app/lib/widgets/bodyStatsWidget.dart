import 'package:flutter/material.dart';

class bodyStatisticsCard extends StatefulWidget {
  final icon, title, body, footer;
  bodyStatisticsCard({this.icon, this.title, this.body, this.footer});

  @override
  State<bodyStatisticsCard> createState() => _bodyStatisticsCardState();
}

class _bodyStatisticsCardState extends State<bodyStatisticsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          // BoxShadow(color: Colors.green, spreadRadius: 8),
          // BoxShadow(color: Colors.yellow, spreadRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Image.asset('assets/images/' + widget.icon),
          Text(widget.title),
          Text(widget.body),
          Text(widget.footer),
        ],
      ),
    );
  }
}
