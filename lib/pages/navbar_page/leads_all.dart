import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';
import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart';

class AllLeads extends StatefulWidget {
  const AllLeads({super.key});

  @override
  State<AllLeads> createState() => _AllLeadsState();
}

class _AllLeadsState extends State<AllLeads> {
  bool isLoading = true;
  List<dynamic> upcomingTasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasksData();
  }

  Future<void> fetchTasksData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/leads/all'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('this is the leadall $data');
        setState(() {
          upcomingTasks = data['rows'] ?? [];
          isLoading = false;
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Leads List',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTasksList(upcomingTasks),
                ],
              ),
            ),
    );
  }

  Widget _buildTasksList(List<dynamic> tasks) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No Leads available'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return TaskItem(
          key: ValueKey(task['lead_id']),
          name: task['lead_name'] ?? 'no name',
          date: task['expected_date_purchase'] ?? 'No Date',
          vehicle: task['PMI'] ?? 'Unknown Vehicle',
          brand: task['brand'] ?? '',
          leadId: task['lead_id'] ?? '',
          taskId: task['task_id'] ?? '',
          isFavorite: task['favourite'] ?? false,
          onFavoriteToggled: fetchTasksData,
        );
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  final String name;
  final String date;
  final String vehicle;
  final String leadId;
  final String taskId;
  final String brand;
  final bool isFavorite;
  final VoidCallback onFavoriteToggled;

  const TaskItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.taskId,
    required this.isFavorite,
    required this.onFavoriteToggled,
    required this.brand,
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
          'https://api.smartassistapp.in/api/favourites/mark-fav/lead/${widget.leadId}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'leadId': widget.leadId, 'favourite': !isFav}),
      );

      if (response.statusCode == 200) {
        setState(() => isFav = !isFav);
        widget.onFavoriteToggled();
      }
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.containerBg,
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            left: BorderSide(
              width: 8.0,
              color: AppColors.sideGreen,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isFav ? Icons.star_rounded : Icons.star_border_rounded,
                      color: isFav
                          ? AppColors.starColorsYellow
                          : AppColors.starBorderColor,
                      size: 40,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserDetails(),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          _date(),
                          const SizedBox(width: 8),
                          _buildVerticalDivider(20),
                          const SizedBox(width: 8),
                          _buildCarModel(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildNavigationButton(),
          ],
        ),
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
      formattedDate = DateFormat('dd/MM/yyyy').format(parseDate);
    } catch (e) {
      formattedDate = widget.date;
    }
    return Row(
      children: [
        const Icon(Icons.phone_in_talk, color: Colors.blue, size: 14),
        const SizedBox(width: 5),
        Text(formattedDate,
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

  Widget _buildNavigationButton() {
    return GestureDetector(
      onTap: () {
        if (widget.leadId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleLeadsById(leadId: widget.leadId),
            ),
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
}
