import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventWidget extends StatefulWidget {
  final DateTime selectedDate;
  final int overdueFollowupsCount;
  final int upcomingFollowupsCount;
  final int upcomingAppointmentsCount;
  final int overdueAppointmentsCount;

  const EventWidget({
    super.key,
    required this.overdueFollowupsCount,
    required this.upcomingFollowupsCount,
    required this.upcomingAppointmentsCount,
    required this.overdueAppointmentsCount,
    required this.selectedDate,
  });

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  String getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Get the screen width
          double screenWidth = constraints.maxWidth;

          // Adjust layout based on screen size
          return Column(
            children: [
              if (widget.upcomingFollowupsCount == 0 &&
                  widget.overdueFollowupsCount == 0)
                Center(child: Text('No follow-ups available.')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Date and Time Section (left-aligned)
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xff7FAEE5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.selectedDate.day}', // Day number (e.g., 13)
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    // '${getDayWithSuffix(DateTime.now().day).substring(DateTime.now().day.toString().length)}', // Suffix part (e.g., 'th', 'st', etc.)
                                    '${getDayWithSuffix(widget.selectedDate.day).substring(widget.selectedDate.day.toString().length)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      height: 0.5,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 5), // Space between day and month
                              Text(
                                '${DateFormat('MMM').format(widget.selectedDate)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              // Time on the next line
                              // SizedBox(height: 5),
                              // Text(
                              //   '12:15 AM',
                              //   style: TextStyle(
                              //       color: Colors.white, fontSize: 10),
                              // ),
                            ],
                          )),
                    ],
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  // Add some space between rows
                  if (screenWidth > 600)
                    const SizedBox(width: 20), // Add space for larger screens

                  // Name Section (right-aligned)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_2_outlined),
                            Text(
                              'Event',
                              style: TextStyle(
                                  fontSize: screenWidth > 600 ? 18 : 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Color(0xffEF5138),
                              size: 12,
                            ),
                            const SizedBox(width: 10),
                            Text('Overdue Follow-Ups ',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 2),
                            const SizedBox(width: 2),
                            Text('${widget.overdueFollowupsCount}',
                                style: TextStyle(
                                    fontSize: screenWidth > 600 ? 20 : 16,
                                    color: const Color(0xffEF5138)))
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Color(0xffEF5138),
                              size: 12,
                            ),
                            const SizedBox(width: 10),
                            Text('Overdue Appointment ',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 2),
                            const SizedBox(width: 2),
                            Text('${widget.overdueAppointmentsCount}',
                                style: TextStyle(
                                    fontSize: screenWidth > 600 ? 20 : 16,
                                    color: const Color(0xffEF5138)))
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Color(0xff27AB3B),
                              size: 12,
                            ),
                            const SizedBox(width: 10),
                            const Text('Upcoming Follow-Ups ',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 2),
                            const SizedBox(width: 2),
                            Text('${widget.upcomingFollowupsCount}',
                                style: TextStyle(
                                    fontSize: screenWidth > 600 ? 20 : 16,
                                    color: const Color(0xff27AB3B)))
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Color(0xff27AB3B),
                              size: 12,
                            ),
                            const SizedBox(width: 10),
                            const Text('Upcoming Appointment ',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 2),
                            const SizedBox(width: 2),
                            Text('${widget.upcomingAppointmentsCount}',
                                style: TextStyle(
                                    fontSize: screenWidth > 600 ? 20 : 16,
                                    color: const Color(0xff27AB3B)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
