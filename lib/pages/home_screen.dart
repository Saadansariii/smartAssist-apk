import 'package:flutter/material.dart';
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
  Widget currentWidget = const CustomRow();
  Widget currentBtn = const SizedBox();
  int _activeButtonIndex = 0;
  int _upcommingButtonIndex = 0;
  final _upcommingBtnFollowups = 0;
  final _upcommingBtnAppointments = 0;
  final _upcommingBtnTestdrive = 0;
  int _selectedBtnIndex = 0;

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
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1EFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    height: 40, // Set height for the container
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          children: [
                            // Follow Ups Button
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _activeButtonIndex = 0;
                                });
                                followUps(_upcommingBtnFollowups);
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: _activeButtonIndex == 0
                                    ? const Color(
                                        0xFF1380FE) // Active color (blue)
                                    : Colors
                                        .transparent, // No background for inactive buttons
                                foregroundColor: _activeButtonIndex == 0
                                    ? Colors.white // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                minimumSize: const Size(110, 40),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text(
                                'FollowUps(6)',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ),

                            // Appointments Button
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _activeButtonIndex =
                                      1; // Set Appointments as active
                                });
                                oppointment(_upcommingBtnAppointments);
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: _activeButtonIndex == 1
                                    ? const Color(
                                        0xFF1380FE) // Active color (blue)
                                    : Colors
                                        .transparent, // No background for inactive buttons
                                foregroundColor: _activeButtonIndex == 1
                                    ? Colors.white // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                minimumSize: const Size(110, 40),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text('Appointments (5)'),
                            ),

                            // Test Drive Button
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _activeButtonIndex =
                                      2; // Set Test Drive as active
                                });
                                testDrive(_upcommingBtnTestdrive);
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: _activeButtonIndex == 2
                                    ? const Color(
                                        0xFF1380FE) // Active color (blue)
                                    : Colors
                                        .transparent, // No background for inactive buttons
                                foregroundColor: _activeButtonIndex == 2
                                    ? Colors.white // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                minimumSize: const Size(110, 40),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text('Test Drive (5)'),
                            ),
                          ],
                        ),
                      ),
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
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(
                                0xFF767676)), // Border around the container
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          // Upcoming Button
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _upcommingButtonIndex = 0;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _upcommingButtonIndex == 0
                                    ? const Color.fromARGB(255, 81, 223, 121)
                                        // ignore: deprecated_member_use
                                        .withOpacity(
                                            0.29) // Active color (green)
                                    : null, // No background for inactive button
                                foregroundColor: _upcommingButtonIndex == 0
                                    ? Colors
                                        .blueGrey // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5), // Add vertical padding
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
                                  _upcommingButtonIndex = 1;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _upcommingButtonIndex == 1
                                    ? const Color.fromRGBO(238, 59, 59, 1)
                                        // ignore: deprecated_member_use
                                        .withOpacity(
                                            .29) // Active color (green)
                                    : Colors
                                        .transparent, // No background for inactive button
                                foregroundColor: _upcommingButtonIndex == 1
                                    ? Colors
                                        .blueGrey // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5), // Add vertical padding
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

              SizedBox(height: 10),
              // leads test drive button

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
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      child: Row(
                        children: [
                          // Follow Ups Button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 0; // Set Follow Ups as active
                                _selectedBtnIndex = 0;
                              });
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: _leadButton == 0
                                  ? const Color(
                                      0xFF1380FE) // Active color (blue)
                                  : Colors
                                      .transparent, // No background for inactive buttons
                              foregroundColor: _leadButton == 0
                                  ? Colors.white // Active text color (white)
                                  : Colors.black, // Inactive text color (black)
                              minimumSize: const Size(121, 50),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                            child: const Text('Leads'),
                          ),

                          // Appointments Button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 1; // Set Appointments as active
                                _selectedBtnIndex = 2;
                              });
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: _leadButton == 1
                                  ? const Color(
                                      0xFF1380FE) // Active color (blue)
                                  : Colors
                                      .transparent, // No background for inactive buttons
                              foregroundColor: _leadButton == 1
                                  ? Colors.white // Active text color (white)
                                  : Colors.black, // Inactive text color (black)
                              minimumSize: const Size(121, 50),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text('Test Drive'),
                          ),

                          // Test Drive Button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 2; // Set Test Drive as active
                                _selectedBtnIndex = 1;
                              });
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: _leadButton == 2
                                  ? const Color(
                                      0xFF1380FE) // Active color (blue)
                                  : Colors
                                      .transparent, // No background for inactive buttons
                              foregroundColor: _leadButton == 2
                                  ? Colors.white // Active text color (white)
                                  : Colors.black, // Inactive text color (black)
                              minimumSize: const Size(121, 50),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text('Orders'),
                          ),
                        ],
                      ),
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

  void followUps(int index) {
    setState(() {
      if (index == 0) {
        currentWidget = const CustomRow();
      } else if (index == 1) {
        currentWidget = const OverdueFollowup();
      }
    });
  }

  void testDrive(int index) {
    setState(() {
      if (index == 0) {
        currentWidget = const TestUpcoming();
      } else if (index == 1) {
        currentWidget = const TestOverdue();
      }
    });
  }

  void oppointment(int index) {
    setState(() {
      if (index == 0) {
        currentWidget = const OppUpcoming();
      } else if (index == 1) {
        currentWidget = const OppOverdue();
      }
    });
  }
}
