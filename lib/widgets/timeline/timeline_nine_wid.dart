import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineNineWid extends StatelessWidget {
  const TimelineNineWid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 235, 235),
          borderRadius: BorderRadius.circular(10)),
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.2, // Align the line properly
        isFirst: false,
        isLast: false,
        beforeLineStyle: LineStyle(
          color: Colors.transparent, // No line before
          thickness: 2,
        ),
        afterLineStyle: LineStyle(
          color: Colors.transparent, // No line after
          thickness: 2,
        ),
        indicatorStyle: IndicatorStyle(
          width: 30,
          height: 30,
          color: Colors.transparent, // No circle indicator
        ),
        startChild: Icon(Icons.person), // Icon as start child
        endChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tira',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 117, 117, 117)),
              ),
              Text(
                'By lily',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    'Test Drive Completed',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.done,
                    size: 14,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
