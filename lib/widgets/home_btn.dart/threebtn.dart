import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_followups/create_Followups_popups.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_first.dart';
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
  final Widget _leadFirstStep = const LeadFirstStep();
  final Widget _createFollowups = const CreateFollowupsPopups();

  bool _isMonthView = true;
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
            GestureDetector(
              onTap: () async {
                final result = await showMenu<String>(
                  context: context,
                  position: const RelativeRect.fromLTRB(200, 230, 30, 0),
                  items: [
                    PopupMenuItem<String>(
                      onTap: () {
                        Future.delayed(Duration.zero, () {
                          // Delayed to ensure PopupMenuItem tap is completed before opening the dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: _createFollowups
                                , // Your modal widget
                              );
                            },
                          );
                        });
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      height: 0,
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
                          // Delayed to ensure PopupMenuItem tap is completed before opening the dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: _leadFirstStep, // Your modal widget
                              );
                            },
                          );
                        });
                      },
                      padding: EdgeInsets.symmetric(vertical: 2),
                      height: 0,
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

                // Optional: Handle menu item selection (if required)
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
        currentWidget,
        SizedBox(height: 10),
        currentWidget,
        SizedBox(height: 10),
        currentWidget,
      ],
    );
  }

  // LeadFirstStep(),

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


// Widget _leadFirstStep(BuildContext context) {
  
//   String? selectedEvent; 

//   return StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) {
//       return SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment
//                         .stretch, // Stretch children horizontally
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Center(
//                             child: Text('Add New leads',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Assign to',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),

//                       Container(
//                         width: double.infinity, // Full width dropdown
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           value: selectedEvent, // Set to selectedEvent
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("Select",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'New Vehicle',
//                             'Old Vehicle',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value:
//                                   value, // Ensure value matches dropdown items
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value; // Update selected event
//                             });
//                           },
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       // Dropdown 2 (Customer/Client)
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text('First name*',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w500)),
//                       ),
//                       const SizedBox(height: 10),

//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: TextField(
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                           decoration: const InputDecoration(
//                             hintText: 'Alex', // Placeholder text
//                             hintStyle:
//                                 TextStyle(color: Colors.grey, fontSize: 12),
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 12), // Padding inside the TextField
//                             border: InputBorder
//                                 .none, // Remove border for custom design
//                           ),
//                           onChanged: (value) {
//                             // Handle text change (optional)
//                             print(value);
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text('Last name*',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w500)),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         width: double.infinity, // Full width text field
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: TextField(
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                           decoration: const InputDecoration(
//                             hintText: 'Carter',
//                             hintStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12), // Placeholder text
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 12), // Padding inside the TextField
//                             border: InputBorder
//                                 .none, // Remove border for custom design
//                           ),
//                           onChanged: (value) {
//                             // Handle text change (optional)
//                             print(value);
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text('Email*',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w500)),
//                       ),
//                       const SizedBox(height: 5),
//                       Container(
//                         width: double.infinity, // Full width text field
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: TextField(
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                           decoration: const InputDecoration(
//                             hintText: 'AlexCarter@gmail.com',
//                             hintStyle:
//                                 TextStyle(color: Colors.grey, fontSize: 12),
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 12), // Padding inside the TextField
//                             border: InputBorder
//                                 .none, // Remove border for custom design
//                           ),
//                           onChanged: (value) {
//                             // Handle text change (optional)
//                             print(value);
//                           },
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       // Row with Buttons
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.black, // Cancel button color
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(
//                                       context); // Close modal on cancel
//                                 },
//                                 child: Text('Cancel',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white)),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue, // Submit button color
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   // Close the current dialog and open the second dialog
//                                   Navigator.pop(
//                                       context); // Close the first dialog
//                                   Future.microtask(() {
//                                     // Immediately queue the second dialog to open after the first closes
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) => Dialog(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         child: _leadSecondStep(
//                                             context), // Your second modal widget
//                                       ),
//                                     );
//                                   });
//                                 },
//                                 child: Text(
//                                   'Next',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
 
 

// Widget _leadSecondStep(BuildContext context) {
//   String? selectedEvent;
//   String? selectedCustomer;

//   return StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Center(
//                             child: Text('Add New leads',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Purchase type :',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity, // Full width dropdown
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           menuWidth: 250,
//                           value: selectedEvent, // Set to selectedEvent
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("Select",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'New Vehicle',
//                             'Old Vehicle',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value:
//                                   value, // Ensure value matches dropdown items
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value; // Update selected event
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Type :',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           menuWidth: 250,
//                           value:
//                               selectedEvent, // Use same value for consistency
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("Select",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'Patrol',
//                             'Diesel',
//                             'EV',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text('Sub Type: *',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w500)),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: TextField(
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                           decoration: const InputDecoration(
//                             hintText: 'Retail',
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 12),
//                             border: InputBorder.none,
//                           ),
//                           onChanged: (value) {
//                             // Handle text change (optional)
//                             print(value);
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Brand',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           menuWidth: 250,
//                           value:
//                               selectedEvent, // Use selectedEvent for consistency
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("Jaguar",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'Land Rover',
//                             'Range Rover',
//                             'Others',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value, // Use valid value
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text('Previous',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white)),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue, // Submit button color
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   // Close the current dialog and open the second dialog
//                                   Navigator.pop(
//                                       context); // Close the first dialog
//                                   Future.microtask(() {
//                                     // Immediately queue the second dialog to open after the first closes
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) => Dialog(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         child: _leadThirdStep(
//                                             context), // Your second modal widget
//                                       ),
//                                     );
//                                   });
//                                 },
//                                 child: Text(
//                                   'Next',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// Widget _leadThirdStep(BuildContext context) {
//   String? selectedEvent;
//   String? selectedCustomer;

//   return StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Center(
//                             child: Text('Add New leads',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Primary model input:',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity, // Full width dropdown
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           menuWidth: 250,
//                           value: selectedEvent, // Set to selectedEvent
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("Discovery",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'Range Rover',
//                             'Others',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value:
//                                   value, // Ensure value matches dropdown items
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value; // Update selected event
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Source :',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           menuWidth: 250,
//                           value:
//                               selectedEvent, // Use same value for consistency
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("Email",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'Email',
//                             'Field Visit',
//                             'Referral',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text('Mobile*',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w500)),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: TextField(
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                           decoration: const InputDecoration(
//                             hintText: '0000000000',
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 12),
//                             border: InputBorder.none,
//                           ),
//                           onChanged: (value) {
//                             // Handle text change (optional)
//                             print(value);
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Enquiry type',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           menuWidth: 250,
//                           value:
//                               selectedEvent, // Use selectedEvent for consistency
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("KMI",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'Generic',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value, // Use valid value
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text('Previous',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white)),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue, // Submit button color
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   // Close the current dialog and open the second dialog
//                                   Navigator.pop(
//                                       context); // Close the first dialog
//                                   Future.microtask(() {
//                                     // Immediately queue the second dialog to open after the first closes
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) => Dialog(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         child: _leadLastStep(
//                                             context), // Your second modal widget
//                                       ),
//                                     );
//                                   });
//                                 },
//                                 child: Text(
//                                   'Next',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// Widget _leadLastStep(BuildContext context) {
//   String? selectedEvent;
//   String? selectedCustomer;

//   return StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Center(
//                             child: Text('Add New leads',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                         child: Text(
//                           'Description :',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity, // Full width dropdown
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color.fromARGB(255, 243, 238, 238),
//                         ),
//                         child: DropdownButton<String>(
//                           menuWidth: 250,
//                           value: selectedEvent, // Set to selectedEvent
//                           hint: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Text("New",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.grey)),
//                           ),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           isExpanded: true,
//                           underline: const SizedBox.shrink(),
//                           items: <String>[
//                             'New Vehicle',
//                             'Old Vehicle',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value:
//                                   value, // Ensure value matches dropdown items
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: Text(value,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black)),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedEvent = value; // Update selected event
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const SizedBox(height: 30),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text('Previous',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white)),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   print('Selected Event: $selectedEvent');
//                                   print('Selected Customer: $selectedCustomer');
//                                   Navigator.pop(context);
//                                 },
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('Submit',
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white)),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
