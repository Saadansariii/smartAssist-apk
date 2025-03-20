import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/Leads/single_details_pages/singleLead_followup.dart';
import 'package:smart_assist/utils/storage.dart';

class FTestdrive extends StatefulWidget {
  const FTestdrive({super.key});

  @override
  State<FTestdrive> createState() => _FTestdriveState();
}

class _FTestdriveState extends State<FTestdrive> {
  bool isLoading = true;
  List<dynamic> upcomingTasks = [];
  List<dynamic> overdueTasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasksData();
  }

  Future<void> fetchTasksData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.smartassistapp.in/api/favourites/events/test-drives/all'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          upcomingTasks = data['data']['upcomingDrives']['rows'] ?? [];
          overdueTasks = data['data']['overdueDrives']['rows'] ?? [];
          isLoading = false;
          print('this is from FOppointment ${Uri.parse}');
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
        print('this is the api appoinment${Uri}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTasksList(upcomingTasks, isUpcoming: true),
          _buildTasksList(overdueTasks, isUpcoming: false),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(List<dynamic> tasks, {required bool isUpcoming}) {
    if (tasks.isEmpty) {
      return Center(
        child: Text(
            'No ${isUpcoming ? "upcoming" : "overdue"} Test drive available'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return TaskItem(
            key: ValueKey(task['event_id']),
            name: task['name'],
            startTime: task['start_time'],
            date: task['start_date'],
            vehicle: 'Discovery Sport',
            leadId: task['lead_id'],
            eventId: task['event_id'],
            isFavorite: task['favourite'] ?? false,
            fetchDashboardData: () {},
            isUpcoming: isUpcoming);
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  final String name, date, vehicle, leadId, eventId, startTime;
  final bool isFavorite;
  final VoidCallback fetchDashboardData;
  final bool isUpcoming;

  const TaskItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.isFavorite,
    required this.eventId,
    required this.startTime,
    required this.fetchDashboardData,
    required this.isUpcoming,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFavorite;
  }

  Future<void> _toggleFavorite() async {
    final token = await Storage.getToken();
    try {
      final response = await http.put(
        Uri.parse(
          'https://api.smartassistapp.in/api/favourites/mark-fav/task/${widget.eventId}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'taskId': widget.eventId, 'favourite': !isFav}),
      );

      if (response.statusCode == 200) {
        setState(() => isFav = !isFav);
        // widget.onFavoriteToggled();
      }
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.containerBg,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(
              width: 8.0,
              color:
                  widget.isUpcoming ? AppColors.sideGreen : AppColors.sideRed,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // IconButton(
            //   icon: Icon(
            //     isFav ? Icons.star_rounded : Icons.star_border_rounded,
            //     color: isFav
            //         ? AppColors.starColorsYellow
            //         : AppColors.starBorderColor,
            //     size: 40,
            //   ),
            //   onPressed: _toggleFavorite,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserDetails(),
                const SizedBox(
                    height: 4), // Spacing between user details and date-car
                Row(
                  children: [
                    _date(),
                    _buildVerticalDivider(20),
                    _buildCarModel(),
                  ],
                ),
              ],
            ),
            _buildNavigationButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    // ✅ Accept context
    return GestureDetector(
      onTap: () {
        if (widget.leadId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FollowupsDetails(leadId: widget.leadId)),
          );
        } else {
          print("Invalid leadId");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: AppColors.arrowContainerColor,
            borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.arrow_forward_ios_rounded,
            size: 25, color: Colors.white),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.name,
            style: GoogleFonts.poppins(
                color: AppColors.fontColor,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _date() {
    String formattedDate = '';
    try {
      DateTime parseDate = DateTime.parse(widget.date);
      formattedDate = DateFormat('dd MMM').format(parseDate);
    } catch (e) {
      formattedDate = widget.date;
    }
    return Row(
      children: [
        const Icon(Icons.directions_car, color: Colors.blue, size: 20),
        const SizedBox(width: 5),
        Text(formattedDate,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _time() {
    String formattedTime = '';
    try {
      DateTime parseDate = DateFormat("HH:mm:ss").parse(widget.startTime);
      formattedTime = DateFormat.jm().format(parseDate);
    } catch (e) {
      formattedTime = widget.startTime;
    }
    return Row(
      children: [
        Text(formattedTime,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildVerticalDivider(double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height,
      width: 1,
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: AppColors.fontColor))),
    );
  }

  Widget _buildCarModel() {
    return Text(
      widget.vehicle,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(fontSize: 10, color: AppColors.fontColor),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
