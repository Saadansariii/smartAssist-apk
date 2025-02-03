import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
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
  List<dynamic> allTasks = [];
  List<dynamic> overdueTasks = [];
  List<dynamic> upcomingTasks = [];

  int allTasksCount = 0;
  int upcomingTasksCount = 0;
  int overdueTasksCount = 0;

  TextEditingController searchController = TextEditingController();

  // Static mock data for tasks
  void _loadStaticData() {
    setState(() {
      allTasks = [
        {
          'name': 'Task 1',
          'due_date': '2025-02-10',
          'lead_id': 'f370a169-36df-4f10-bd16-1ecf7fed25cb',
          'task_id': 'task-001',
        },
        {
          'name': 'Task 2',
          'due_date': '2025-02-15',
          'lead_id': 'f370a169-36df-4f10-bd16-1ecf7fed25cb',
          'task_id': 'task-002',
        }
      ];
      upcomingTasks = [
        {
          'name': 'Upcoming Task 1',
          'due_date': '2025-02-10',
          'lead_id': 'f370a169-36df-4f10-bd16-1ecf7fed25cb',
          'task_id': 'upcoming-001',
        },
        {
          'name': 'Upcoming Task 2',
          'due_date': '2025-02-12',
          'lead_id': 'f370a169-36df-4f10-bd16-1ecf7fed25cb',
          'task_id': 'upcoming-002',
        }
      ];
      overdueTasks = [
        {
          'name': 'Overdue Task 1',
          'due_date': '2025-01-30',
          'lead_id': 'f370a169-36df-4f10-bd16-1ecf7fed25cb',
          'task_id': 'overdue-001',
        }
      ];

      allTasksCount = allTasks.length;
      upcomingTasksCount = upcomingTasks.length;
      overdueTasksCount = overdueTasks.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStaticData(); // Load static data when the widget initializes
  }

  // Function to filter tasks based on search query
  void _filterTasks(String query) {
    setState(() {
      allTasks = allTasks
          .where((task) =>
              task['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _getCurrentWidget() {
    if (_upcommingButtonIndex == 0) {
      return FollowupsUpcoming(upcomingFollowups: upcomingTasks);
    } else if (_upcommingButtonIndex == 1) {
      return FollowupsUpcoming(upcomingFollowups: upcomingTasks);
    } else {
      return OverdueFollowup(overdueeFollowups: overdueTasks);
    }
  }

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
          'All Followupss',
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
                          controller: searchController,
                          onChanged: _filterTasks,
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
                    const SizedBox(width: 20),
                    Container(
                      width: 250,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF767676),
                          width: .5,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          // All
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
                                        .withOpacity(0.29)
                                    : null,
                                foregroundColor: _upcommingButtonIndex == 0
                                    ? Colors.blueGrey
                                    : Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                side: BorderSide(
                                  color: _upcommingButtonIndex == 0
                                      ? Color.fromARGB(255, 78, 109, 248)
                                      : Colors.transparent,
                                  width: .5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
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
                                        .withOpacity(0.29)
                                    : null,
                                foregroundColor: _upcommingButtonIndex == 1
                                    ? Colors.blueGrey
                                    : Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                side: BorderSide(
                                  color: _upcommingButtonIndex == 1
                                      ? const Color.fromARGB(255, 81, 223, 121)
                                      : Colors.transparent,
                                  width: .5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
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
                                        .withOpacity(0.29)
                                    : Colors.transparent,
                                foregroundColor: _upcommingButtonIndex == 2
                                    ? Colors.blueGrey
                                    : Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                side: BorderSide(
                                  color: _upcommingButtonIndex == 2
                                      ? Color.fromRGBO(236, 81, 81, 1)
                                          .withOpacity(0.59)
                                      : Colors.transparent,
                                  width: .5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
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
            _getCurrentWidget(), // Display the correct widget dynamically
          ],
        ),
      ),
    );
  }
}
