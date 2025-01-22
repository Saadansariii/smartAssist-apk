import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/oppointment/overdue.dart';
import 'package:smart_assist/widgets/oppointment/upcoming.dart';
import 'package:smart_assist/widgets/testdrive/overdue.dart';
import 'package:smart_assist/widgets/testdrive/upcoming.dart';

class Threebtn extends StatefulWidget {
  const Threebtn({super.key});

  @override
  State<Threebtn> createState() => _ThreebtnState();
}

class _ThreebtnState extends State<Threebtn> {
  int _selectedBtnIndex = 0;

  Widget currentWidget = const CustomRow();
  int _activeButtonIndex = 0;
  int _childButtonIndex = 0;

  int _upcomingBtnFollowups = 0;
  int _upcomingBtnAppointments = 0;
  int _upcomingBtnTestdrive = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE1EFFF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: SizedBox(
              height: 37,
              width: double.infinity,
              child: Row(
                children: [
                  // Follow Ups Button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeButtonIndex = 0;
                        });
                        followUps(_upcomingBtnFollowups);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: _activeButtonIndex == 0
                            ? const Color(0xFF1380FE)
                            : Colors.transparent,
                        foregroundColor: _activeButtonIndex == 0
                            ? Colors.white
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: Text(
                        'FollowUps(6)',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                  // Appointments Button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeButtonIndex = 1;
                        });
                        oppointment(_upcomingBtnAppointments);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: _activeButtonIndex == 1
                            ? const Color(0xFF1380FE)
                            : Colors.transparent,
                        foregroundColor: _activeButtonIndex == 1
                            ? Colors.white
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: Text('Appointments(5)',
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ),
                  ),

                  // Test Drive Button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeButtonIndex = 2;
                        });
                        testDrive(_upcomingBtnTestdrive);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: _activeButtonIndex == 2
                            ? const Color(0xFF1380FE)
                            : Colors.transparent,
                        foregroundColor: _activeButtonIndex == 2
                            ? Colors.white
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: Text('Test Drive(5)',
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Container(
                width: 150, // Set width of the container
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xFF767676),
                      width: .5), // Border around the container
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    // Upcoming Button
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              _childButtonIndex = 0; // Set Upcoming as active
                            });

                            if (_activeButtonIndex == 0) {
                              followUps(0);
                            } else if (_activeButtonIndex == 1) {
                              oppointment(0);
                            } else if (_activeButtonIndex == 2) {
                              testDrive(0);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _childButtonIndex == 0
                                ? const Color(0xFF51DF79)
                                    .withOpacity(0.6) // Green for Upcoming
                                : Colors.transparent,
                            foregroundColor: _childButtonIndex == 0
                                ? Colors.white
                                : Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            side: BorderSide(
                              color: _childButtonIndex == 0
                                  ? const Color.fromARGB(255, 81, 223, 121)
                                  : Colors.transparent,
                              width: 1, // Border width
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Optional: Rounded corners
                            ),
                          ),
                          child: Text(
                            'Upcoming',
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color.fromARGB(255, 121, 119, 119)),
                          )),
                    ),

                    // Overdue Button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _childButtonIndex = 1; // Set Overdue as active
                          });

                          if (_activeButtonIndex == 0) {
                            followUps(1);
                          } else if (_activeButtonIndex == 1) {
                            oppointment(1);
                          } else if (_activeButtonIndex == 2) {
                            testDrive(1);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: _childButtonIndex == 1
                              ? const Color(0xFFEE3B3B)
                                  .withOpacity(0.6) // Red for Overdue
                              : Colors.transparent,
                          foregroundColor: _childButtonIndex == 1
                              ? Colors.white
                              : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          side: BorderSide(
                            color: _childButtonIndex == 1
                                ? Color.fromRGBO(236, 81, 81, 1)
                                    .withOpacity(0.59)
                                : Colors.transparent,
                            width: 1, // Border width
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Optional: Rounded corners
                          ),
                        ),
                        child: Text('Overdue',
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color.fromARGB(255, 121, 119, 119))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(Icons.add, size: 30),
            ),
            // ListTile(
            //   title: Text('data'),
            //   trailing: PopupMenuButton(
            //       itemBuilder: (context) => [
            //             PopupMenuItem(child: Text('hi')),
            //             PopupMenuItem(child: Text('h2'))
            //           ]),
            // ),
             
          ],
        ),
        currentWidget,
        SizedBox(height: 10),
        currentWidget,
        SizedBox(height: 10),
        currentWidget,
      ],
    );
  }

  void followUps(int index) {
    setState(() {
      _upcomingBtnFollowups = index;
      if (index == 0) {
        currentWidget = const CustomRow(); // Upcoming Follow-ups
      } else if (index == 1) {
        currentWidget = const OverdueFollowup(); // Overdue Follow-ups
      }
    });
  }

// Test Drive toggle logic
  void testDrive(int index) {
    setState(() {
      _upcomingBtnTestdrive = index;
      if (index == 0) {
        currentWidget = const TestUpcoming(); // Upcoming Test Drive
      } else if (index == 1) {
        currentWidget = const TestOverdue(); // Overdue Test Drive
      }
    });
  }

// Appointments toggle logic
  void oppointment(int index) {
    setState(() {
      _upcomingBtnAppointments = index;
      if (index == 0) {
        currentWidget = const OppUpcoming(); // Upcoming Appointments
      } else if (index == 1) {
        currentWidget = const OppOverdue(); // Overdue Appointments
      }
    });
  }
}
