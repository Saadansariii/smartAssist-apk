import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_followups/create_Followups_popups.dart';

class AddFollowups extends StatefulWidget {
  final String leadId;
  const AddFollowups({
    super.key,
    required this.leadId,
  });

  @override
  State<AddFollowups> createState() => _AddFollowupsState();
}

class _AddFollowupsState extends State<AddFollowups> {
  final Widget _createFollowups = const CreateFollowupsPopups();
  List<dynamic> _originalAllTasks = [];
  List<dynamic> _originalUpcomingTasks = [];
  List<dynamic> _originalOverdueTasks = [];
  List<dynamic> _filteredAllTasks = [];
  List<dynamic> _filteredUpcomingTasks = [];
  List<dynamic> _filteredOverdueTasks = [];
  int _upcommingButtonIndex = 0;
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;
  // final leadId = widget.leadId;
  // String? leadId;

  @override
  void initState() {
    super.initState();
    fetchTasks();
    // leadId = widget.leadId;
    print('this is the leadId ${widget.leadId}');
  }

  Future<void> fetchTasks() async {
    setState(() => _isLoading = true);
    try {
      final token = await Storage.getToken();
      final String apiUrl =
          "https://api.smartassistapp.in/api/admin/leads/tasks/all/${widget.leadId}";

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _originalAllTasks = data['allTasks']?['rows'] ?? [];
          _originalUpcomingTasks = data['upcomingTasks']?['rows'] ?? [];
          _originalOverdueTasks = data['overdueTasks']?['rows'] ?? [];
          _filteredAllTasks = List.from(_originalAllTasks);
          _filteredUpcomingTasks = List.from(_originalUpcomingTasks);
          _filteredOverdueTasks = List.from(_originalOverdueTasks);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAllTasks = List.from(_originalAllTasks);
        _filteredUpcomingTasks = List.from(_originalUpcomingTasks);
        _filteredOverdueTasks = List.from(_originalOverdueTasks);
      } else {
        final lowercaseQuery = query.toLowerCase();
        void filterList(List<dynamic> original, List<dynamic> filtered) {
          filtered.clear();
          filtered.addAll(original.where((task) =>
              task['name'].toString().toLowerCase().contains(lowercaseQuery) ||
              task['subject']
                  .toString()
                  .toLowerCase()
                  .contains(lowercaseQuery)));
        }

        filterList(_originalAllTasks, _filteredAllTasks);
        filterList(_originalUpcomingTasks, _filteredUpcomingTasks);
        filterList(_originalOverdueTasks, _filteredOverdueTasks);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          ),
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'All Followups',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _createFollowups, // Your follow-up widget
                  );
                },
              );
            },
            icon: const Icon(Icons.add, color: Colors.white, size: 36),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    controller: searchController,
                    onChanged: _filterTasks,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE1EFFF),
                      contentPadding: const EdgeInsets.fromLTRB(1, 4, 0, 4),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: const Icon(Icons.mic, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
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
                            _buildFilterButton(
                              index: 0,
                              text: 'All',
                              activeColor:
                                  const Color.fromARGB(255, 81, 109, 121),
                            ),
                            _buildFilterButton(
                              index: 1,
                              text: 'Upcoming',
                              activeColor:
                                  const Color.fromARGB(255, 81, 223, 121),
                            ),
                            _buildFilterButton(
                              index: 2,
                              text: 'Overdue',
                              activeColor: const Color.fromRGBO(238, 59, 59, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _upcommingButtonIndex == 0
                    ? Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  FollowupsUpcoming(
                                    upcomingFollowups: _filteredUpcomingTasks,
                                  ),
                                  OverdueFollowup(
                                    overdueeFollowups: _filteredOverdueTasks,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : _upcommingButtonIndex == 1
                        ? FollowupsUpcoming(
                            upcomingFollowups: _filteredUpcomingTasks,
                          )
                        : OverdueFollowup(
                            overdueeFollowups: _filteredOverdueTasks,
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required int index,
    required String text,
    required Color activeColor,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: () => setState(() => _upcommingButtonIndex = index),
        style: TextButton.styleFrom(
          backgroundColor: _upcommingButtonIndex == index
              ? activeColor.withOpacity(0.29)
              : null,
          foregroundColor:
              _upcommingButtonIndex == index ? Colors.blueGrey : Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 5),
          side: BorderSide(
            color: _upcommingButtonIndex == index
                ? activeColor
                : Colors.transparent,
            width: .5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
