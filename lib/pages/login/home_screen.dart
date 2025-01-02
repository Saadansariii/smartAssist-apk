import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeButtonIndex = 0;
  int _upcommingButtonIndex = 0;
  int _leadButton = 0;

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
                                  _activeButtonIndex =
                                      0; // Set Follow Ups as active
                                });
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
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                                      'Beth Ford',
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
                                        const Text(
                                          'Today 7am',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
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
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Range Rover\nvelar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Image.asset('assets/arrowButton.png')],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
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
                                      'Rose Dean',
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
                                        const Text(
                                          'Today 3am',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
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
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Discovery',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Image.asset('assets/arrowButton.png')],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
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
                                        const Text(
                                          'Today 5am',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
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
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Defender',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Image.asset('assets/arrowButton.png')],
                      ),
                    ),
                  ],
                ),
              ),
              // leads test drive button

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
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
                      child: Row(
                        children: [
                          // Follow Ups Button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 0; // Set Follow Ups as active
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
                              minimumSize: const Size(110, 40),
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
                              minimumSize: const Size(110, 40),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text('Test Drive'),
                          ),

                          // Test Drive Button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _leadButton = 2; // Set Test Drive as active
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
                              minimumSize: const Size(110, 40),
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

              // Container(
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF1380FE),
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: const Color(0xFFE1EFFF),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           // child flex
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               // child one flex
              //               Padding(
              //                 padding: EdgeInsets.only(right: 5),
              //                 child: Row(
              //                   children: [
              //                     Text(
              //                         'Almost there, you need\n 5 more leads to\n achieve your goal!')
              //                   ],
              //                 ),
              //               ),
              //               // child two flex
              //               Padding(
              //                 padding: EdgeInsets.only(left: 5),
              //                 child: Row(
              //                   children: [
              //                     Text(
              //                       '5',
              //                       style: TextStyle(
              //                           fontSize: 30,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //               )
              //             ],
              //           )
              //         ],
              //       ),

              //     ),
              //   ),
              // )

              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1380FE), // Outer container color
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                        // Optional rounded corners
                      ),
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Inner container color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            // First Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // First child
                                SizedBox(
                                  height: 140,
                                  width: 180,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 0, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE1EFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Almost there, you need\n 5 more leads\n to achieve\n your goal',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '5',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Second child
                                SizedBox(
                                  height: 140,
                                  width: 180,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 15, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE1EFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Keep it up! You are\n doing great!',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '10',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Second Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Third child
                                SizedBox(
                                  height: 140,
                                  width: 180,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE1EFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Keep pushing,\nYou are almost there!',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '3',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Fourth child
                                SizedBox(
                                  height: 140,
                                  width: 180,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 15, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE1EFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Don’t stop now!\nSuccess is near!',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '7',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
