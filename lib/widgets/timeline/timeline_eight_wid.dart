import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

class TimelineEightWid extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  const TimelineEightWid({super.key, required this.events});

  String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      return DateFormat("d MMM").format(parsedDate); // Outputs "22 May"
    } catch (e) {
      print('Error formatting date: $e');
      return 'N/A';
    }
  }

  String formatTime(String createdAt) {
    try {
      // ✅ Convert ISO date string into DateTime object
      DateTime dateTime = DateTime.parse(createdAt);

      // ✅ Format to 12-hour time (hh:mm AM/PM)
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      print("Error formatting time: $e");
      return 'Invalid Time';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reverse the events list to show from bottom to top
    final reversedEvents = events.reversed.toList();

    return Column(
      children: List.generate(reversedEvents.length, (index) {
        final event = reversedEvents[index];
        String dueDate = _formatDate(event['due_date'] ?? 'N/A');
        String subject = event['subject'] ?? 'No Subject';
        String priority = event['priority'] ?? 'N/A';
        String createdTime = event['created_at'] ?? 'N/A';
        // String endDate = event['due_date'] ?? 'N/A';

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.25,
          // First item (bottom) is last, last item (top) is first
          isFirst: index == (reversedEvents.length - 11),
          isLast: index == (reversedEvents.length - 0),
          beforeLineStyle: const LineStyle(
            color: Color.fromARGB(255, 102, 102, 102),
            thickness: 2,
          ),
          afterLineStyle: const LineStyle(
            color: Color.fromARGB(255, 102, 102, 102),
            thickness: 2,
          ),
          indicatorStyle: IndicatorStyle(
            padding: const EdgeInsets.only(left: 5),
            width: 30,
            height: 30,
            color: Colors.blue,
            iconStyle: IconStyle(
              iconData: Icons.keyboard_double_arrow_down_rounded,
              color: Colors.white,
            ),
          ),
          startChild: Container(
            decoration: BoxDecoration(
              color: const Color(0xffE7F2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              formatTime(createdTime),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          endChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffE7F2FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Due Date: ',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: '$dueDate\n',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        
                        TextSpan(
                          text: 'Subject: ',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: '$subject\n',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Priority: ',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: '$priority\n',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        // TextSpan(
                        //   text: 'Due Date: ',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        // TextSpan(
                        //   text: '$startDate\n',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // TextSpan(
                        //   text: 'End Date: ',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        // TextSpan(
                        //   text: '$endDate\n',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.black,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
              ],
            ),
          ),
        );
      }),
    );
  }
}
