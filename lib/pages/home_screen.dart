import 'package:flutter/material.dart';
import 'package:smart_assist/pages/Add_followups.dart';
import 'package:smart_assist/pages/calenderPages.dart/calender.dart';
import 'package:smart_assist/pages/opportunity.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/home_btn.dart/leads.dart';
import 'package:smart_assist/widgets/home_btn.dart/order.dart';
import 'package:smart_assist/widgets/home_btn.dart/test_drive.dart';
import 'package:smart_assist/widgets/oppointment/overdue.dart';
import 'package:smart_assist/widgets/oppointment/upcoming.dart';
import 'package:smart_assist/widgets/testdrive/overdue.dart';
import 'package:smart_assist/widgets/testdrive/upcoming.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Widget currentWidget = const CustomRow();
  // Widget currentBtn = const SizedBox();
  // int _activeButtonIndex = 0;
  // int _upcommingButtonIndex = 0;
  // final _upcommingBtnFollowups = 0;
  // final _upcommingBtnAppointments = 0;
  // final _upcommingBtnTestdrive = 0;
  int _selectedBtnIndex = 0;

  // Widgets for FollowUp, TestDrive, and Appointments
  Widget currentWidget = const CustomRow();
  int _activeButtonIndex = 0;
  int _childButtonIndex = 0;

// Separate indices for each section's upcoming/overdue toggle
  int _upcomingBtnFollowups = 0;
  int _upcomingBtnAppointments = 0;
  int _upcomingBtnTestdrive = 0;

  final List<Widget> _widgets = [
    const Leads(),
    const Order(),
    const TestDrive(),
  ];

  int _leadButton = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1380FE),
        title: const Text(
          'Good morning Richard !',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: Colors.white,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFE1EFFF),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(1, 4, 0, 4),
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                              prefixIcon:
                                  const Icon(Icons.menu, color: Colors.grey),
                              suffixIcon:
                                  const Icon(Icons.mic, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Horizontal Scrollable Button Row
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                            child: const Text('FollowUps (6)',
                                textAlign: TextAlign.center),
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
                            child: const Text('Appointments (5)',
                                textAlign: TextAlign.center),
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
                            child: const Text('Test Drive (5)',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Upcoming and Overdue Buttons in a container with border
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 5, 10),
                    child: Container(
                      width: 200, // Set width of the container
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
                                  _childButtonIndex =
                                      0; // Set Upcoming as active
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                              child: Text('Upcoming',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ),
                          ),

                          // Overdue Button
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _childButtonIndex =
                                      1; // Set Overdue as active
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
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
                ],
              ),

              // this is onclick fn for upcoming and overdue.
              currentWidget,
              SizedBox(height: 5),
              currentWidget,
              SizedBox(height: 5),
              currentWidget,

              // SizedBox(height: 10),
              // leads test drive button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddFollowups()));
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 36,
                    ),
                  )
                ],
              ),
              // SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1EFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      children: [
                        // Follow Ups Button
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 0;
                                _selectedBtnIndex = 0;
                              });
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: _leadButton == 0
                                  ? const Color(0xFF1380FE)
                                  : Colors.transparent,
                              foregroundColor: _leadButton == 0
                                  ? Colors.white
                                  : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            child: const Text('Leads',
                                textAlign: TextAlign.center),
                          ),
                        ),

                        // Appointments Button
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 1;
                                _selectedBtnIndex = 2;
                              });
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: _leadButton == 1
                                  ? const Color(0xFF1380FE)
                                  : Colors.transparent,
                              foregroundColor: _leadButton == 1
                                  ? Colors.white
                                  : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            child: const Text('Test Drive',
                                textAlign: TextAlign.center),
                          ),
                        ),

                        // Test Drive Button
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 2;
                                _selectedBtnIndex = 1;
                              });
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: _leadButton == 2
                                  ? const Color(0xFF1380FE)
                                  : Colors.transparent,
                              foregroundColor: _leadButton == 2
                                  ? Colors.white
                                  : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            child: const Text('Orders',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              _widgets[_selectedBtnIndex],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white, // Background color of the fixed area
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column doesn’t expand unnecessarily
              children: [
                Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                // Image.asset('assets/Leadss.png', height: 25, width: 30),
                Text('Leads', style: TextStyle(color: Colors.blue)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column doesn’t expand unnecessarily
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Opportunity()),
                    );
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_fire_department_sharp),
                      // Image.asset('assets/Opportunity.png', height: 25, width: 30),
                      Text('Opportunity'),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column doesn’t expand unnecessarily
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Calender()),
                    );
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      Text('Calendar'),
                    ],
                  ),
                ),
                // Image.asset('assets/calender.png', height: 25, width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Follow-ups toggle logic
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
