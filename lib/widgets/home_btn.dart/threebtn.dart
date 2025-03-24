import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/pages/Leads/All_field_bottomArrow/all_appointment.dart';
import 'package:smart_assist/pages/Leads/All_field_bottomArrow/all_followups.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/Leads/All_field_bottomArrow/all_testdrive.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/home_btn.dart/dashboard_popups/appointment_popup.dart';
import 'package:smart_assist/widgets/home_btn.dart/dashboard_popups/create_Followups_popups.dart';
import 'package:smart_assist/widgets/home_btn.dart/dashboard_popups/create_leads.dart';
import 'package:smart_assist/widgets/oppointment/overdue.dart';
import 'package:smart_assist/widgets/oppointment/upcoming.dart';
import 'package:smart_assist/widgets/testdrive/overdue.dart';
import 'package:smart_assist/widgets/testdrive/upcoming.dart';

class Threebtn extends StatefulWidget {
  final String leadId;
  final int overdueFollowupsCount;
  final int overdueAppointmentsCount;
  final int overdueTestDrivesCount;
  final List<dynamic> upcomingFollowups;
  final List<dynamic> overdueFollowups;
  final List<dynamic> upcomingAppointments;
  final List<dynamic> overdueAppointments;
  final List<dynamic> upcomingTestDrives;
  final List<dynamic> overdueTestDrives;
  final Future<void> Function() refreshDashboard;
  // final VoidCallback refreshDashboard;
  const Threebtn(
      {super.key,
      required this.leadId,
      required this.upcomingFollowups,
      required this.overdueFollowups,
      required this.upcomingAppointments,
      required this.overdueAppointments,
      required this.refreshDashboard,
      required this.overdueFollowupsCount,
      required this.overdueAppointmentsCount,
      required this.overdueTestDrivesCount,
      required this.upcomingTestDrives,
      required this.overdueTestDrives});

  @override
  State<Threebtn> createState() => _ThreebtnState();
}

class _ThreebtnState extends State<Threebtn> {
  // final Widget _leadFirstStep = const LeadFirstStep();
  final Widget _createFollowups = const CreateFollowupsPopups();
  final Widget _createAppoinment = const AppointmentPopup();
  String? leadId;
  Map<int, int> _childSelection = {0: 0, 1: 0, 2: 0};

// add more field

  bool isLoading = true;
  late Widget? currentWidget;

  @override
  void initState() {
    super.initState();
    leadId = widget.leadId;
    print('this is the lead id $leadId');
    print(widget.leadId);
    _childButtonIndex = 0;
    currentWidget = FollowupsUpcoming(
      upcomingFollowups: widget.upcomingFollowups,
      isNested: false,
    );

    // fetchDashboardData();
    // fetchDashboardData().then((_) {
    //   setState(() {
    //     isLoading = false;
    //     followUps(_upcomingBtnFollowups);
    //   });
    // });

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
              color: AppColors.searchBar,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SizedBox(
              height: 32,
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
                        followUps(_childSelection[0]!);
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
                            : AppColors.fontColor,
                        // padding: const EdgeInsets.symmetric(vertical: 0),
                        textStyle: AppFont.threeBtn(context),
                      ),
                      child: const Text(
                        'FollowUps',
                        textAlign: TextAlign.center,
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
                        oppointment(_childSelection[0]!);
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
                            : AppColors.fontColor,
                        textStyle: AppFont.threeBtn(context),
                      ),
                      child: const Text(
                        'Appointments',
                        textAlign: TextAlign.center,
                      ),
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
                            : AppColors.fontColor,
                        // padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: AppFont.threeBtn(context),
                      ),
                      child: const Text(
                        'Test Drive',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedToggleSwitch<int>.size(
                current: _childButtonIndex,
                values: const [0, 1], // 0 = Upcoming, 1 = Overdue
                onChanged: (index) {
                  setState(() {
                    _childButtonIndex = index;
                    _childSelection[_activeButtonIndex] = index;
                  });

                  // Call the correct API function
                  if (_activeButtonIndex == 0) {
                    followUps(index);
                  } else if (_activeButtonIndex == 1) {
                    oppointment(index);
                  } else if (_activeButtonIndex == 2) {
                    testDrive(index);
                  }
                },
                height: 27,
                indicatorSize: const Size(95, 25), // Adjusted for better fit
                iconAnimationType: AnimationType.onHover,
                animationDuration:
                    const Duration(milliseconds: 300), // Smooth transition
                borderWidth: 0.6,
                style: ToggleStyle(
                  backgroundColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  indicatorColor: _childButtonIndex == 0
                      ? const Color(0xFF51DF79)
                          .withOpacity(0.29) // Green for Upcoming
                      : const Color(0xFFFFF5F4), // Light Red for Overdue
                ),
                iconBuilder: (index) {
                  int overdueCount = 0;
                  if (_activeButtonIndex == 0) {
                    overdueCount = widget.overdueFollowupsCount;
                  } else if (_activeButtonIndex == 1) {
                    overdueCount = widget.overdueAppointmentsCount;
                  } else if (_activeButtonIndex == 2) {
                    overdueCount = widget.overdueTestDrivesCount;
                  }

                  return Transform.scale(
                    scale: 0.8, // Adjust scale to prevent size increase
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          index == 0 ? 'Upcoming' : 'Overdue',
                          textScaleFactor:
                              0.9, // Prevents auto-scaling when selected
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.96),
                          ),
                        ),
                        // const SizedBox(width: 5),
                        if (index == 1 &&
                            overdueCount > 0) // Show count only for Overdue
                          Text(
                            '($overdueCount)',
                            textScaleFactor: 1.0, // Keeps text size stable
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.92),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 5,
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        //       child: Container(
        //         width: 150, // Set width of the container
        //         height: 27,
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //               color: const Color(0xFF767676).withOpacity(0.3),
        //               width: 0.6), // Border around the container
        //           borderRadius: BorderRadius.circular(30),
        //         ),
        //         child: Row(
        //           children: [
        //             // Upcoming Button
        //             Expanded(
        //               child: TextButton(
        //                   onPressed: () {
        //                     setState(() {
        //                       _childButtonIndex = 0; // Set Upcoming as active
        //                       _childSelection[_activeButtonIndex] = 0;
        //                     });

        //                     if (_activeButtonIndex == 0) {
        //                       followUps(0);
        //                     } else if (_activeButtonIndex == 1) {
        //                       oppointment(0);
        //                     } else if (_activeButtonIndex == 2) {
        //                       testDrive(0);
        //                     }
        //                   },
        //                   style: TextButton.styleFrom(
        //                     backgroundColor: _childButtonIndex == 0
        //                         ? const Color(0xFF51DF79)
        //                             .withOpacity(0.29) // Green for Upcoming
        //                         : Colors.transparent,
        //                     foregroundColor: _childButtonIndex == 0
        //                         ? Colors.white
        //                         : Colors.black,
        //                     padding: const EdgeInsets.symmetric(vertical: 5),
        //                     side: BorderSide(
        //                       color: _childButtonIndex == 0
        //                           ? const Color.fromARGB(255, 81, 223, 121)
        //                           : Colors.transparent,
        //                       width: 1, // Border width
        //                     ),
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(
        //                           30), // Optional: Rounded corners
        //                     ),
        //                   ),
        //                   child: Text(
        //                     'Upcoming',
        //                     style: GoogleFonts.poppins(
        //                         fontSize: 10,
        //                         fontWeight: FontWeight.w400,
        //                         color:
        //                             const Color(0xff000000).withOpacity(0.56)),
        //                   )),
        //             ),

        //             // Overdue Button
        //             Expanded(
        //               child: TextButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     _childButtonIndex = 1; // Mark this button as active
        //                     _childSelection[_activeButtonIndex] = 1;
        //                   });

        //                   // Call the respective API function
        //                   if (_activeButtonIndex == 0) {
        //                     followUps(1);
        //                   } else if (_activeButtonIndex == 1) {
        //                     oppointment(1);
        //                   } else if (_activeButtonIndex == 2) {
        //                     testDrive(1);
        //                   }
        //                 },
        //                 style: TextButton.styleFrom(
        //                   backgroundColor: _childButtonIndex == 1
        //                       ? const Color(
        //                           0xFFFFF5F4) // Red highlight when active
        //                       : Colors.transparent,
        //                   foregroundColor: _childButtonIndex == 1
        //                       ? Colors.white
        //                       : Colors.black,
        //                   padding: const EdgeInsets.symmetric(vertical: 5),
        //                   side: BorderSide(
        //                     color: _childButtonIndex == 1
        //                         ? const Color.fromRGBO(236, 81, 81, 1)
        //                             .withOpacity(0.59)
        //                         : Colors.transparent,
        //                     width: 1,
        //                   ),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(30),
        //                   ),
        //                 ),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     Text(
        //                       _activeButtonIndex == 0
        //                           ? 'Overdue'
        //                           : _activeButtonIndex == 1
        //                               ? 'Overdue'
        //                               : 'Overdue',
        //                       style: GoogleFonts.poppins(
        //                         fontSize: 10,
        //                         fontWeight: FontWeight.w400,
        //                         color:
        //                             const Color(0xff000000).withOpacity(0.56),
        //                       ),
        //                     ),
        //                     const SizedBox(width: 5),
        //                     if ((_activeButtonIndex == 0 &&
        //                             (widget.overdueFollowupsCount > 0 ||
        //                                 widget.overdueFollowupsCount > 0)) ||
        //                         (_activeButtonIndex == 1 &&
        //                             (widget.overdueAppointmentsCount > 0 ||
        //                                 widget.overdueAppointmentsCount > 0)) ||
        //                         (_activeButtonIndex == 2 &&
        //                             (widget.overdueTestDrivesCount > 0 ||
        //                                 widget.overdueTestDrivesCount > 0)))
        //                       Text(
        //                         (_activeButtonIndex == 0)
        //                             ? '(${widget.overdueFollowupsCount})'
        //                             : (_activeButtonIndex == 1)
        //                                 ? '(${widget.overdueAppointmentsCount})'
        //                                 : '(${widget.overdueTestDrivesCount})',
        //                         style: GoogleFonts.poppins(
        //                           fontSize: 10,
        //                           fontWeight: FontWeight.w400,
        //                           color:
        //                               const Color(0xff000000).withOpacity(0.56),
        //                         ),
        //                       ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        // show data
        currentWidget ?? const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (_activeButtonIndex == 0) {
                  setState(() {
                    _activeButtonIndex = 0;
                    followUps(0);
                  });
                  followUps(_upcomingBtnFollowups);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddFollowups(),
                    ),
                  );
                } else if (_activeButtonIndex == 1) {
                  setState(() {
                    _activeButtonIndex = 1;
                  });
                  oppointment(_upcomingBtnAppointments);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AllAppointment(), // Navigate to newFollowups() if selected 1
                    ),
                  );
                } else if (_activeButtonIndex == 2) {
                  setState(() {
                    _activeButtonIndex = 2;
                  });
                  testDrive(_upcomingBtnTestdrive);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AllTestdrive(), // Navigate to newFollowups() if selected 1
                    ),
                  );
                }
              },
              child: const Icon(
                color: AppColors.fontColor,
                Icons.keyboard_arrow_down_outlined,
                size: 36,
              ),
            ),
          ],
        )
      ],
    );
  }

  void followUps(int type) {
    setState(() {
      _upcomingBtnFollowups = type;

      if (type == 0) {
        currentWidget = FollowupsUpcoming(
          upcomingFollowups: widget.upcomingFollowups,
          isNested: false,
        );
        print('this is upcoming');
        // print(widget.upcomingFollowups);
      } else {
        currentWidget = OverdueFollowup(
          overdueeFollowups: widget.overdueFollowups,
          isNested: false,
        );
        print('this is overdue');
        print(widget.overdueFollowups);
      }
    });
  }

// Test Drive toggle logic
  void testDrive(int index) {
    setState(() {
      _upcomingBtnTestdrive = index;
      if (index == 0) {
        currentWidget = TestUpcoming(
          upcomingTestDrive: widget.upcomingTestDrives,
          isNested: false,
        ); // Upcoming Test Drive
      } else if (index == 1) {
        currentWidget = TestOverdue(
          overdueTestDrive: widget.overdueTestDrives,
          isNested: false,
        ); // Overdue Test Drive
      }
    });
  }

// Appointments toggle logic
  void oppointment(int index) {
    setState(() {
      _upcomingBtnAppointments = index;
      if (index == 0) {
        currentWidget = OppUpcoming(
          upcomingOpp: widget.upcomingAppointments,
          isNested: false,
        ); // Upcoming Appointments
      } else if (index == 1) {
        currentWidget = OppOverdue(
          overdueeOpp: widget.overdueAppointments,
          isNested: false,
        );
      }
    });
  }
}
