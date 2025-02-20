import 'package:flutter/material.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/home_screens/all_followups.dart';
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
  final String leadId;
  final List<dynamic> upcomingFollowups;
  final List<dynamic> overdueFollowups;
  final List<dynamic> upcomingAppointments;
  final List<dynamic> overdueAppointments;
  const Threebtn(
      {super.key,
      required this.leadId,
      required this.upcomingFollowups,
      required this.overdueFollowups,
      required this.upcomingAppointments,
      required this.overdueAppointments});

  @override
  State<Threebtn> createState() => _ThreebtnState();
}

class _ThreebtnState extends State<Threebtn> {
  // final Widget _leadFirstStep = const LeadFirstStep();
  final Widget _createFollowups = const CreateFollowupsPopups();
  final Widget _createAppoinment = const AppointmentPopup();
  String? leadId;
  // List<dynamic> upcomingFollowups = [];
  // List<dynamic> overdueFollowups = [];
  // List<dynamic> upcomingAppointments = [];
  // List<dynamic> overdueAppointments = [];

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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_activeButtonIndex == 0)
                  GestureDetector(
                    onTap: () async {
                      final result = await showMenu<String>(
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 230, 30, 0),
                        items: [
                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            height: 20,
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return Dialog(
                                //       insetPadding: EdgeInsets.zero,
                                //       backgroundColor: Colors.white,
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: _createFollowups,
                                //     );
                                //   },
                                // );
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
                                        child: _createFollowups,
                                      ),
                                    );
                                  },
                                );
                              });
                            },
                            value: 'followup',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.add_call,
                                    size: 20,
                                    color: AppColors.fontColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Create Followups',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.fontColor),
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
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return Dialog(
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: const LeadFirstStep(
                                //         firstName: '',
                                //         lastName: '',
                                //         selectedPurchaseType: '',
                                //         selectedSubType: '',
                                //         selectedFuelType: '',
                                //         selectedBrand: '',
                                //         email: '',
                                //         selectedEvent: '',
                                //       ), // Lead modal
                                //     );
                                //   },
                                // );
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.person_add_alt_1,
                                    size: 20,
                                    color: AppColors.fontColor,
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
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 220, 30, 0),
                        items: [
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

                                          child: _createAppoinment,
                                          // Appointment modal
                                        ));
                                  },
                                );
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
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Create Appointment',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.fontColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // const PopupMenuDivider(height: 1),
                          // PopupMenuItem<String>(
                          //   height: 20,
                          //   onTap: () {
                          //     Future.delayed(Duration.zero, () {
                          //       // showDialog(
                          //       //   context: context,
                          //       //   builder: (context) {
                          //       //     return Dialog(
                          //       //       shape: RoundedRectangleBorder(
                          //       //         borderRadius: BorderRadius.circular(10),
                          //       //       ),
                          //       //       child:const LeadFirstStep(
                          //       //         firstName: '',
                          //       //         lastName: '',
                          //       //         selectedPurchaseType: '',
                          //       //         selectedSubType: '',
                          //       //         selectedFuelType: '',
                          //       //         selectedBrand: '',
                          //       //         email: '',
                          //       //         selectedEvent: '',
                          //       //       ), // Lead modal
                          //       //     );
                          //       //   },
                          //       // );
                          //       showDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           return Dialog(
                          //             backgroundColor: Colors.transparent,
                          //             insetPadding: EdgeInsets
                          //                 .zero, // Remove default padding
                          //             child: Container(
                          //               width:
                          //                   MediaQuery.of(context).size.width,
                          //               margin: const EdgeInsets.symmetric(
                          //                   horizontal:
                          //                       16), // Add some margin for better UX
                          //               decoration: BoxDecoration(
                          //                 color: Colors.white,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10),
                          //               ),
                          //               child: const LeadFirstStep(
                          //                 firstName: '',
                          //                 lastName: '',
                          //                 selectedPurchaseType: '',
                          //                 selectedSubType: '',
                          //                 selectedFuelType: '',
                          //                 selectedBrand: '',
                          //                 email: '',
                          //                 selectedEvent: '',
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //       );
                          //     });
                          //   },
                          //   value: 'lead',
                          //   child: Center(
                          //     child: Text(
                          //       'Create Lead',
                          //       textAlign: TextAlign.center,
                          //       style: GoogleFonts.poppins(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            height: 20,
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return Dialog(
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: const LeadFirstStep(
                                //         firstName: '',
                                //         lastName: '',
                                //         selectedPurchaseType: '',
                                //         selectedSubType: '',
                                //         selectedFuelType: '',
                                //         selectedBrand: '',
                                //         email: '',
                                //         selectedEvent: '',
                                //       ), // Lead modal
                                //     );
                                //   },
                                // );
                                showDialog(
                                  context: context,
                                  // barrierDismissible: false, it work for click outside not closed
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
        currentWidget ?? SizedBox(height: 10),
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFollowups(),
                  ),
                );
              },
              child: const Icon(
                color: AppColors.fontColor,
                Icons.keyboard_arrow_down_outlined,
                size: 36,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Future<void> fetchDashboardData() async {
  //   final token = await Storage.getToken();
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       print('Decoded Data: $data');
  //       setState(() {
  //         upcomingFollowups = data['upcomingFollowups'];
  //         overdueFollowups = data['overdueFollowups'];
  //         overdueAppointments = data['overdueAppointments'];
  //         upcomingAppointments = data['upcomingAppointments'];
  //         greeting = data.containsKey('greetings') && data['greetings'] is List
  //             ? data['greetings']
  //             : [];
  //         print(data['greetings']);
  //         if (upcomingFollowups.isNotEmpty) {
  //           leadId = upcomingFollowups[0]['lead_id'];
  //         }
  //       });
  //     } else {
  //       print("Failed to load data: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   }
  // }

  void followUps(int type) {
    setState(() {
      _upcomingBtnFollowups = type;

      if (type == 0) {
        currentWidget = FollowupsUpcoming(
          upcomingFollowups: widget.upcomingFollowups,
        );
        print('this is upcoming');
        // print(widget.upcomingFollowups);
      } else {
        currentWidget = OverdueFollowup(
          overdueeFollowups: widget.overdueFollowups,
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
          upcomingOpp: widget.upcomingAppointments,
        ); // Upcoming Appointments
      } else if (index == 1) {
        currentWidget = OppOverdue(overdueeOpp: widget.overdueAppointments);
      }
    });
  }
}
