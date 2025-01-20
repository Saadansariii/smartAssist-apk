import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final IconData? icon;
  final Widget startChild;
  final Widget endChild;
  final bool showIndicator;
  final bool showBeforeLine;
  // final bool showBefire

  const Timeline(
      {super.key,
      required this.isFirst,
      required this.isLast,
      this.icon,
      required this.startChild,
      required this.endChild,
      this.showBeforeLine = true,
      this.showIndicator = true});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.19,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: showBeforeLine ? Colors.blue : Colors.transparent,
      ),
      indicatorStyle: showIndicator
          ? IndicatorStyle(
              width: 25,
              height: 25,
              color: Colors.blue,
              iconStyle: icon != null
                  ? IconStyle(
                      iconData: icon!, color: Colors.white, fontSize: 20)
                  : null,
            )
          : const IndicatorStyle(
              width: 0,
              color: Colors.transparent,
            ),
      startChild: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [startChild],
      ),
      endChild: endChild,
    );
  }
}
