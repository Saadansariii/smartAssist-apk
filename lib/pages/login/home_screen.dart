import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to track which button is active
  int _activeButtonIndex = 0;
  int _upcommingButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        height: 60,
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
                                  fontWeight: FontWeight.w300),
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
              SizedBox(
                height: 60, // Set height for the container
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: Row(
                      children: [
                        // Follow Ups Button
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _activeButtonIndex =
                                  0; // Set Follow Ups as active
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _activeButtonIndex == 0
                                ? const Color(0xFF1380FE) // Active color (blue)
                                : Colors
                                    .transparent, // No background for inactive buttons
                            foregroundColor: _activeButtonIndex == 0
                                ? Colors.white // Active text color (white)
                                : Colors.black, // Inactive text color (black)
                            minimumSize: const Size(10, 40),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text('Follow Ups (6)'),
                        ),

                        // Appointments Button
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _activeButtonIndex =
                                  1; // Set Appointments as active
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _activeButtonIndex == 1
                                ? const Color(0xFF1380FE) // Active color (blue)
                                : Colors
                                    .transparent, // No background for inactive buttons
                            foregroundColor: _activeButtonIndex == 1
                                ? Colors.white // Active text color (white)
                                : Colors.black, // Inactive text color (black)
                            minimumSize: const Size(130, 40),
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
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _activeButtonIndex == 2
                                ? const Color(0xFF1380FE) // Active color (blue)
                                : Colors
                                    .transparent, // No background for inactive buttons
                            foregroundColor: _activeButtonIndex == 2
                                ? Colors.white // Active text color (white)
                                : Colors.black, // Inactive text color (black)
                            minimumSize: const Size(130, 40),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text('Test Drive (5)'),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                                  _upcommingButtonIndex =
                                      0; // Set Upcoming as active
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _upcommingButtonIndex == 0
                                    ? const Color.fromARGB(255, 81, 223,
                                        121) // Active color (green)
                                    : Colors
                                        .transparent, // No background for inactive button
                                foregroundColor: _upcommingButtonIndex == 0
                                    ? Colors.white // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5), // Add vertical padding
                              ),
                              child: const Text('Upcoming'),
                            ),
                          ),
                          // Overdue Button
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _upcommingButtonIndex =
                                      1; // Set Overdue as active
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _upcommingButtonIndex == 1
                                    ? const Color.fromRGBO(
                                        238, 59, 59, 1) // Active color (green)
                                    : Colors
                                        .transparent, // No background for inactive button
                                foregroundColor: _upcommingButtonIndex == 1
                                    ? Colors.white // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5), // Add vertical padding
                              ),
                              child: const Text('Overdue'),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                              left: BorderSide(
                                width: 8.0,
                                color: Color.fromARGB(255, 81, 223, 121),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ClipRect(
                                  child: Image.asset('assets/Star.png'),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // const Text('data')
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      'Tira Smith',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF767676)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/call.png',
                                          height:
                                              30, // Adjust image size as needed
                                          width: 30,
                                        ),
                                        const Text('Today 3am')
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 1.0, color: Colors.grey))),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Range rover'),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
