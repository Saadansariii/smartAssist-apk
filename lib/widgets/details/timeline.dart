import 'package:flutter/material.dart';
import 'package:smart_assist/widgets/details/timelinetext.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final IconData icon;
  final Widget startChild;

  const Timeline(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.icon, // Initialize icon parameter
      required this.startChild});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.15,
      startChild: startChild,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(color: Colors.blue),
      indicatorStyle: IndicatorStyle(
        color: Colors.blue,
        width: 40,
        iconStyle: IconStyle(
          iconData: icon, // Use the dynamic icon
          color: Colors.white,
        ),
      ),
    );
  }
}
