import 'package:flutter/material.dart';
import 'package:smart_assist/pages/home_screen.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/opp_follup.dart/overdue_opp.dart';
import 'package:smart_assist/widgets/opp_follup.dart/upcoming.dart';

class AddFollowups extends StatefulWidget {
  const AddFollowups({super.key});

  @override
  State<AddFollowups> createState() => _AddFollowupsState();
}

class _AddFollowupsState extends State<AddFollowups> {
  Widget currentWidgetOverdue1 = const OverdueFollowup();
  Widget currentWidgetOverdue2 = const OverdueOpp();
  Widget currentWidget1 = const OppFollUps();
  Widget currentWidget = const CustomRow();
  int _upcommingButtonIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: const Text(
          'All Follow ups', // e.g., January 2025
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 36,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                const Icon(Icons.search, color: Colors.grey),
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
            Column(
              children: [
                Row(
                  children: [
                    // Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 250, // Set width of the container
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF767676),
                          width: .5,
                        ),
                        // Border around the container
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          // all
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _upcommingButtonIndex = 0;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _upcommingButtonIndex == 0
                                    ? const Color.fromARGB(255, 78, 109, 248)
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
                                side: BorderSide(
                                  color: _upcommingButtonIndex == 0
                                      ? Color.fromARGB(255, 78, 109, 248)
                                      : Colors.transparent,
                                  width: .5, // Border width
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Optional: Rounded corners
                                ),
                              ),
                              child: const Text('All',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey)),
                            ),
                          ),

                          // Upcoming Button
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _upcommingButtonIndex = 1;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _upcommingButtonIndex == 1
                                    ? const Color.fromARGB(255, 81, 223, 121)
                                        // ignore: deprecated_member_use
                                        .withOpacity(
                                            0.29) // Active color (green)
                                    : null, // No background for inactive button
                                foregroundColor: _upcommingButtonIndex == 1
                                    ? Colors
                                        .blueGrey // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5), // Add vertical padding
                                side: BorderSide(
                                  color: _upcommingButtonIndex == 1
                                      ? const Color.fromARGB(255, 81, 223, 121)
                                      : Colors.transparent,
                                  width: .5, // Border width
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Optional: Rounded corners
                                ),
                              ),
                              child: Text('Upcoming',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey)),
                            ),
                          ),
                          // Overdue Button
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _upcommingButtonIndex = 2;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _upcommingButtonIndex == 2
                                    ? const Color.fromRGBO(238, 59, 59, 1)
                                        // ignore: deprecated_member_use
                                        .withOpacity(
                                            .29) // Active color (green)
                                    : Colors
                                        .transparent, // No background for inactive button
                                foregroundColor: _upcommingButtonIndex == 2
                                    ? Colors
                                        .blueGrey // Active text color (white)
                                    : Colors
                                        .black, // Inactive text color (black)
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5), // Add vertical padding
                                side: BorderSide(
                                  color: _upcommingButtonIndex == 2
                                      ? Color.fromRGBO(236, 81, 81, 1)
                                          .withOpacity(0.59)
                                      : Colors.transparent,
                                  width: .5, // Border width
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Optional: Rounded corners
                                ),
                              ),
                              child: Text('Overdue',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                if (_upcommingButtonIndex == 0) ...[
                  currentWidget,
                  SizedBox(height: 10),
                  currentWidget,
                  const SizedBox(height: 10),
                  currentWidget1,
                  SizedBox(height: 10),
                  currentWidget1,
                  const SizedBox(height: 10),
                  currentWidgetOverdue1,
                  SizedBox(height: 10),
                  currentWidgetOverdue1,
                  const SizedBox(height: 10),
                  currentWidgetOverdue2,
                  SizedBox(height: 10),
                  currentWidgetOverdue2,
                  const SizedBox(height: 10),
                ] else if (_upcommingButtonIndex == 1) ...[
                  currentWidget,
                  const SizedBox(height: 10),
                  currentWidget1,
                  SizedBox(height: 10),
                  currentWidget1,
                  SizedBox(height: 10),
                  currentWidget1,
                ] else if (_upcommingButtonIndex == 2) ...[
                  const SizedBox(height: 10),
                  currentWidgetOverdue2,
                  const SizedBox(height: 10),
                  currentWidgetOverdue1,
                  const SizedBox(height: 10),
                  currentWidgetOverdue1,
                  const SizedBox(height: 10),
                  currentWidgetOverdue2,
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}
