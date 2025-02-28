import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/home_screens/all_appointment.dart';
import 'package:smart_assist/pages/home_screens/all_followups.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/appointment_popup.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_followups/create_Followups_popups.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_leads.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_first.dart';
import 'package:smart_assist/widgets/oppointment/overdue.dart';
import 'package:smart_assist/widgets/oppointment/upcoming.dart';
import 'package:smart_assist/widgets/testdrive/overdue.dart';
import 'package:smart_assist/widgets/testdrive/upcoming.dart';

class Threebtn extends StatefulWidget {
  final String leadId;
  final List<dynamic> upcomingFollowups;
  final List<dynamic> overdueFollowups;
  final List<dynamic> upcomingAppointments;
  final List<dynamic> overdueAppointments;
  final Future<void> Function() refreshDashboard;
  // final VoidCallback refreshDashboard;
  const Threebtn(
      {super.key,
      required this.leadId,
      required this.upcomingFollowups,
      required this.overdueFollowups,
      required this.upcomingAppointments,
      required this.overdueAppointments,
      required this.refreshDashboard});

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
                        textStyle: const TextStyle(fontSize: 10),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'FollowUps',
                            style: GoogleFonts.poppins(
                                fontSize: 11, fontWeight: FontWeight.w300),
                          ),
                        ),
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
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text('Appointments',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 11, fontWeight: FontWeight.w300)),
                        ),
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
                        textStyle: const TextStyle(fontSize: 11),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text('Test Drive',
                              style: GoogleFonts.poppins(
                                  fontSize: 11, fontWeight: FontWeight.w400)),
                        ),
                      ),
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
                height: 27,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xFF767676).withOpacity(0.3),
                      width: 0.6), // Border around the container
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
                              _childSelection[_activeButtonIndex] = 0;
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
                            _childButtonIndex = 1; // Set Overdue as active
                            _childSelection[_activeButtonIndex] = 1;
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
                              ? const Color(0xFFFFF5F4) // Red for Overdue
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
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_activeButtonIndex == 0)
                  GestureDetector(
                    onTap: () async {
                      final result = await showMenu<String>(
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 230, 30, 0),
                        color: Colors.white,
                        items: [
                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            height: 20,
                            onTap: () {
                              Future.delayed(Duration.zero, () async {
                                final dialogResult = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.zero,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal:
                                                16), // Add some margin for better UX
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: _createFollowups,
                                      ),
                                    );
                                  },
                                );
                                if (dialogResult == true) {
                                  await widget.refreshDashboard();
                                }
                              });
                            },
                            value: 'followup',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(
                                      Icons.add_call,
                                      size: 20,
                                      color: AppColors.fontColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 13),
                                    child: Text(
                                      'Create Followups',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.fontColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // const PopupMenuDivider(height: 0.1),
                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            height: 20,
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets
                                          .zero, // Remove default padding
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal:
                                                16), // Add some margin for better UX
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // child: const LeadFirstStep(
                                        //   firstName: '',
                                        //   lastName: '',
                                        //   selectedPurchaseType: '',
                                        //   selectedSubType: '',
                                        //   selectedFuelType: '',
                                        //   selectedBrand: '',
                                        //   email: '',
                                        //   selectedEvent: '',
                                        // ),
                                        child: CreateLeads(),
                                      ),
                                    );
                                  },
                                );
                              });
                            },
                            value: 'lead',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(
                                      Icons.person_add_alt_1,
                                      size: 20,
                                      color: AppColors.fontColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Create Leads',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.fontColor),
                                  ),
                                ],
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
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: AppColors.fontColor,
                      ),
                    ),
                  ),
                if (_activeButtonIndex == 1)
                  GestureDetector(
                    onTap: () async {
                      final result = await showMenu<String>(
                        elevation: 2,
                        color: Colors.white,
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 220, 30, 0),
                        items: [
                          // PopupMenuItem<String>(
                          //   padding: EdgeInsets.zero,
                          //   height: 20,
                          //   onTap: () {
                          //     Future.delayed(
                          //       Duration.zero,
                          //       () {
                          //         showDialog(
                          //           context: context,
                          //           builder: (context) {
                          //             return Dialog(
                          //               backgroundColor: Colors.transparent,
                          //               insetPadding: EdgeInsets
                          //                   .zero, // Remove default padding
                          //               child: Container(
                          //                 width:
                          //                     MediaQuery.of(context).size.width,
                          //                 margin: const EdgeInsets.symmetric(
                          //                     horizontal:
                          //                         16), // Add some margin for better UX
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   borderRadius:
                          //                       BorderRadius.circular(10),
                          //                 ),

                          //                 child: _createAppoinment,
                          //                 // Appointment modal
                          //               ),
                          //             );
                          //           },
                          //         );

                          //       },
                          //     );
                          //   },
                          //   value: 'appointment',
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 0, vertical: 15),
                          //     child: Row(
                          //       children: [
                          //         const Padding(
                          //           padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          //           child: Icon(
                          //             Icons.add_call,
                          //             size: 20,
                          //             color: AppColors.fontColor,
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           width: 4,
                          //         ),
                          //         Text(
                          //           'Create Appointment',
                          //           style: GoogleFonts.poppins(
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500,
                          //               color: AppColors.fontColor),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            height: 20,
                            onTap: () {
                              Future.delayed(Duration.zero, () async {
                                final dialogResult = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets
                                          .zero, // Remove default padding
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal:
                                                16), // Add margin for better UX
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:
                                            _createAppoinment, // Appointment modal
                                      ),
                                    );
                                  },
                                );
                                if (dialogResult == true) {
                                  await widget.refreshDashboard();
                                }
                              });
                            },
                            value: 'appointment',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(
                                      Icons.add_call,
                                      size: 20,
                                      color: AppColors.fontColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Create Appointment',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.fontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            height: 20,
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.zero,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal:
                                                16), // Add some margin for better UX
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const LeadFirstStep(
                                          firstName: '',
                                          lastName: '',
                                          selectedPurchaseType: '',
                                          selectedSubType: '',
                                          selectedFuelType: '',
                                          selectedBrand: '',
                                          email: '',
                                          selectedEvent: '',
                                        ),
                                      ),
                                    );
                                  },
                                );
                              });
                            },
                            value: 'lead',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(
                                      Icons.person_add_alt_1,
                                      size: 20,
                                      color: AppColors.fontColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Create Leads',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.fontColor),
                                  ),
                                ],
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
        currentWidget ?? const SizedBox(height: 10),
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
