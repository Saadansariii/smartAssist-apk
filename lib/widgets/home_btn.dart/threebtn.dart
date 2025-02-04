import 'package:flutter/material.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/appointment_popup.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_followups/create_Followups_popups.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_first.dart';
import 'package:smart_assist/widgets/oppointment/overdue.dart';
import 'package:smart_assist/widgets/oppointment/upcoming.dart';
import 'package:smart_assist/widgets/testdrive/overdue.dart';
import 'package:smart_assist/widgets/testdrive/upcoming.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Threebtn extends StatefulWidget {
  const Threebtn({super.key});

  @override
  State<Threebtn> createState() => _ThreebtnState();
}

class _ThreebtnState extends State<Threebtn> {
  final Widget _leadFirstStep = const LeadFirstStep();
  final Widget _createFollowups = const CreateFollowupsPopups();
  final Widget _createAppoinment = const AppointmentPopup();

  List<dynamic> upcomingFollowups = [];
  List<dynamic> overdueFollowups = [];
  List<dynamic> upcomingAppointments = [];
  List<dynamic> overdueAppointments = [];
// add more field

  bool isLoading = true;
  late Widget currentWidget;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchDashboardData();
  //   _activeButtonIndex = 0;
  //   currentWidget = FollowupsUpcoming(
  //     upcomingFollowups: upcomingFollowups,
  //   );
  // }

  @override
  void initState() {
    super.initState();
    currentWidget = FollowupsUpcoming(
      upcomingFollowups: upcomingFollowups,
    );

    // fetchDashboardData();
    fetchDashboardData().then((_) {
      setState(() {
        isLoading = false;
        followUps(_upcomingBtnFollowups);
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        followUps(_upcomingBtnFollowups);
      });
    });
  }

  int _activeButtonIndex = 0;

  bool _isMonthView = true;
  int _selectedBtnIndex = 0;

  // Widget currentWidget =   FollowupsUpcoming(
  //   upcomingFollowups: upcomingFollowups,
  // );

  // int _activeButtonIndex = 0;
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
                          followUps(0);
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
                      color: const Color(0xFF767676).withOpacity(0.3),
                      width: 1), // Border around the container
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    // Upcoming Button
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              _childButtonIndex = 0;
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
                                    .withOpacity(0.29) // Green for Upcoming
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
                                    const Color(0xff000000).withOpacity(0.56)),
                          )),
                    ),

                    // Overdue Button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _childButtonIndex = 1;
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
                              ? const Color(0xFFFFF5F4)
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
                                    const Color(0xff000000).withOpacity(0.56))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () async {
            //     final result = await showMenu<String>(
            //       context: context,
            //       position: const RelativeRect.fromLTRB(200, 230, 30, 0),
            //       items: [
            //         PopupMenuItem<String>(
            //           onTap: () {
            //             Future.delayed(Duration.zero, () {
            //               // Delayed to ensure PopupMenuItem tap is completed before opening the dialog
            //               showDialog(
            //                 context: context,
            //                 builder: (context) {
            //                   return Dialog(
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(10),
            //                     ),
            //                     child: _createFollowups, // Your modal widget
            //                   );
            //                 },
            //               );
            //             });
            //           },
            //           padding:
            //               EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            //           height: 0,
            //           value: 'followup',
            //           child: Center(
            //             child: Text(
            //               'Create Followups',
            //               textAlign: TextAlign.center,
            //               style: GoogleFonts.poppins(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           ),
            //         ),
            //         PopupMenuDivider(height: 1),
            //         PopupMenuItem<String>(
            //           onTap: () {
            //             Future.delayed(Duration.zero, () {
            //               // Delayed to ensure PopupMenuItem tap is completed before opening the dialog
            //               showDialog(
            //                 context: context,
            //                 builder: (context) {
            //                   return Dialog(
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(10),
            //                     ),
            //                     child: _leadFirstStep, // Your modal widget
            //                   );
            //                 },
            //               );
            //             });
            //           },
            //           padding: EdgeInsets.symmetric(vertical: 2),
            //           height: 0,
            //           value: 'lead',
            //           child: Center(
            //             child: Text(
            //               'Create Lead',
            //               textAlign: TextAlign.center,
            //               style: GoogleFonts.poppins(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     );

            //     // Optional: Handle menu item selection (if required)
            //     if (result != null) {
            //       print('Selected: $result');
            //     }
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            //     child: Icon(Icons.add, size: 30),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_activeButtonIndex == 0)
                  GestureDetector(
                    onTap: () async {
                      final result = await showMenu<String>(
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 230, 30, 0),
                        items: [
                          PopupMenuItem<String>(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child:
                                          _createFollowups, // Follow-ups modal
                                    );
                                  },
                                );
                              });
                            },
                            value: 'followup',
                            child: Center(
                              child: Text(
                                'Create Followups',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuDivider(height: 1),
                          PopupMenuItem<String>(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: _leadFirstStep, // Lead modal
                                    );
                                  },
                                );
                              });
                            },
                            value: 'lead',
                            child: Center(
                              child: Text(
                                'Create Lead',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                      if (result != null) {
                        print('Selected: $result');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(Icons.add, size: 30),
                    ),
                  ),
                if (_activeButtonIndex == 1)
                  GestureDetector(
                    onTap: () async {
                      final result = await showMenu<String>(
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 230, 30, 0),
                        items: [
                          PopupMenuItem<String>(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: _createAppoinment,
                                      // Appointment modal
                                    );
                                  },
                                );
                              });
                            },
                            value: 'appointment',
                            child: Center(
                              child: Text(
                                'Create Appointment',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuDivider(height: 1),
                          PopupMenuItem<String>(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: _leadFirstStep, // Lead modal
                                    );
                                  },
                                );
                              });
                            },
                            value: 'lead',
                            child: Center(
                              child: Text(
                                'Create Lead',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                      if (result != null) {
                        print('Selected: $result');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(Icons.add, size: 30),
                    ),
                  ),
              ],
            ),
          ],
        ),

        // show data
        currentWidget, 
      ],
    );
  }

  Future<void> fetchDashboardData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> data = json.decode(response.body);
        print('Decoded Data: $data');
        setState(() {
          upcomingFollowups = data['upcomingFollowups'];
          overdueFollowups = data['overdueFollowups'];
          overdueAppointments = data['overdueAppointments'];
          upcomingAppointments = data['upcomingAppointments'];
          // print("widget.upcomingFollowups8888");
          // print(data['upcomingFollowups']);
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
  // LeadFirstStep(),

  // void followUps(int type) {
  //   setState(() {
  //     _upcomingBtnFollowups = type;
  //     print("widget.upcomingFollowups");
  //     print(upcomingFollowups);
  //     if (type == 0) {
  //       currentWidget = FollowupsUpcoming(
  //         upcomingFollowups: upcomingFollowups,
  //       ); // Upcoming Follow-ups
  //     } else {
  //       currentWidget = OverdueFollowup(
  //         overdueeFollowups: overdueFollowups,
  //       );
  //     }
  //   });
  // }

  void followUps(int type) {
    setState(() {
      _upcomingBtnFollowups = type;
      print("widget.upcomingFollowups");
      print(upcomingFollowups);

      if (type == 0) {
        currentWidget = FollowupsUpcoming(
          upcomingFollowups: upcomingFollowups,
        );
      } else {
        currentWidget = OverdueFollowup(
          overdueeFollowups: overdueFollowups,
        );
      }
    });
  }

// Test Drive toggle logic
  void testDrive(int index) {
    setState(() {
      _upcomingBtnTestdrive = index;
      if (index == 0) {
        currentWidget = TestUpcoming(); // Upcoming Test Drive
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
        currentWidget = OppUpcoming(
          upcomingOpp: upcomingAppointments,
        ); // Upcoming Appointments
      } else if (index == 1) {
        currentWidget = OppOverdue(overdueeOpp: overdueAppointments);
      }
    });
  }
}
