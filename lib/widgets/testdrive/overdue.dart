import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/Leads/single_details_pages/singleLead_followup.dart';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart';

class TestOverdue extends StatefulWidget {
  final List<dynamic> overdueTestDrive;
  final bool isNested;
  const TestOverdue({
    super.key,
    required this.overdueTestDrive,
    required this.isNested,
  });

  @override
  State<TestOverdue> createState() => _TestOverdueState();
}

class _TestOverdueState extends State<TestOverdue> {
  List<dynamic> upcomingTestDrives = [];
  Future<void> _toggleFavorite(String eventId, int index) async {
    final token = await Storage.getToken();
    final url = Uri.parse(
        'https://api.smartassistapp.in/api/favourites/mark-fav/event/$eventId');

    try {
      setState(() {
        widget.overdueTestDrive[index]['favourite'] =
            !(widget.overdueTestDrive[index]['favourite'] ?? false);
      });

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'eventId': eventId,
          'favourite': widget.overdueTestDrive[index]['favourite'],
        }),
      );

      if (response.statusCode != 200) {
        setState(() {
          widget.overdueTestDrive[index]['favourite'] =
              !(widget.overdueTestDrive[index]['favourite'] ?? false);
        });
        print('Failed to mark favorite: ${response.body}');
      }
    } catch (e) {
      setState(() {
        widget.overdueTestDrive[index]['favourite'] =
            !(widget.overdueTestDrive[index]['favourite'] ?? false);
      });
      print('Error marking favorite: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    upcomingTestDrives = widget.overdueTestDrive;
    print('this is testdrive');
    print(widget.overdueTestDrive);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.overdueTestDrive.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(child: Text('No upcoming TestDrive available')),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: widget.isNested
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      itemCount: widget.overdueTestDrive.length,
      itemBuilder: (context, index) {
        var item = widget.overdueTestDrive[index];

        if (!(item.containsKey('name') &&
            item.containsKey('start_date') &&
            item.containsKey('lead_id') &&
            item.containsKey('event_id'))) {
          return ListTile(title: Text('Invalid data at index $index'));
        }

        return Dismissible(
          key: ValueKey(item['event_id']),
          direction:
              DismissDirection.horizontal, // Enable both left & right swipe
          background: Container(
            color: AppColors.white,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.yellow, size: 35),
                const SizedBox(width: 10),
                Text("Prime",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.blue,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "TestDrive",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.phone, color: Colors.white, size: 28),
              ],
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              _toggleFavorite(item['event_id'], index);
              return false; // Do not remove the item, just mark favorite
            } else if (direction == DismissDirection.endToStart) {
              print("Call action triggered for ${item['name']}");
              return false; // Do not remove the item, just trigger call
            }
            return false;
          },
          child: upcomingTestDrivesItem(
            key: ValueKey(item['event_id']),
            name: item['name'],
            startTime: item['start_time'],
            date: item['start_date'],
            vehicle: 'Discovery Sport',
            leadId: item['lead_id'],
            eventId: item['event_id'],
            isFavorite: item['favourite'] ?? false,
            fetchDashboardData: () {},
          ),
        );
      },
    );
  }
}

class upcomingTestDrivesItem extends StatelessWidget {
  final String name, date, vehicle, leadId, eventId, startTime;
  final bool isFavorite;
  final VoidCallback fetchDashboardData;

  const upcomingTestDrivesItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.isFavorite,
    required this.fetchDashboardData,
    required this.eventId,
    required this.startTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: _buildFollowupCard(context), // ✅ Pass context here
    );
  }

  Widget _buildFollowupCard(BuildContext context) {
    // ✅ Accept context
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.containerBg,
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(width: 8.0, color: AppColors.sideGreen),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              if (isFavorite)
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.starColorsYellow,
                  size: 40,
                ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildUserDetails(),
                      _buildVerticalDivider(20),
                      _buildCarModel(),
                    ],
                  ),
                  Row(
                    children: [
                      _date(),
                      const SizedBox(
                        width: 4,
                      ),
                      _time()
                    ],
                  ),
                ],
              ),
            ],
          ),
          _buildNavigationButton(context), // ✅ Pass context here
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    // ✅ Accept context
    return GestureDetector(
      onTap: () {
        if (leadId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FollowupsDetails(leadId: leadId)),
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
        Text(name,
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
      DateTime parseDate = DateTime.parse(date);
      formattedDate = DateFormat('dd MMM').format(parseDate);
    } catch (e) {
      formattedDate = date;
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
      DateTime parseDate = DateFormat("HH:mm:ss").parse(startTime);
      formattedTime = DateFormat.jm().format(parseDate);
    } catch (e) {
      formattedTime = startTime;
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
      vehicle,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(fontSize: 10, color: AppColors.fontColor),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
