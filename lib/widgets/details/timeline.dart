import 'package:flutter/material.dart';
import 'package:smart_assist/widgets/details/timelinetext.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final IconData? icon;
  final Widget startChild;
  final Widget endChild;
  final bool showIndicator;
  final bool showBeforeLine;

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
      startChild: startChild,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: showBeforeLine ? Colors.blue : Colors.transparent,
      ),
      indicatorStyle: showIndicator
          ? IndicatorStyle(
              width: 40,
              color: Colors.blue,
              iconStyle: icon != null
                  ? IconStyle(
                      iconData: icon!,
                      color: Colors.white,
                    )
                  : null,
            )
          : const IndicatorStyle(
              width: 0,
              color: Colors.transparent,
            ),
      endChild: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white,
          child: endChild,
        ),
      ),
    );
  }
}
