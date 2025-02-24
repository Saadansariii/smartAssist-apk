import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';

// ---------------- FOLLOWUPS UPCOMING LIST ----------------
// class FollowupsUpcoming extends StatefulWidget {
//   final List<dynamic> upcomingFollowups;
//   const FollowupsUpcoming({
//     super.key,
//     required this.upcomingFollowups,
//   });

//   @override
//   State<FollowupsUpcoming> createState() => _FollowupsUpcomingState();
// }

// class _FollowupsUpcomingState extends State<FollowupsUpcoming> {
//   bool isLoading = false;
//   List<dynamic> upcomingFollowups = [];
//   bool _showLoader = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDashboardData();
//     upcomingFollowups = widget.upcomingFollowups;
//     print('this is coming upcomingfollowups on page');
//     print(widget.upcomingFollowups);
//   }

//   Future<void> fetchDashboardData() async {
//     _showLoader = true;
//     final token = await Storage.getToken();
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json'
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           upcomingFollowups = data['upcomingFollowups'];
//           _showLoader = false;
//         });
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//         setState(() {
//           _showLoader = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       setState(() {
//         _showLoader = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_showLoader) {
//       return Container(
//         height: 250,
//         child: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (upcomingFollowups.isEmpty) {
//       return Container(
//         height: 250,
//         child: const Center(child: Text('No upcoming followups available')),
//       );
//     }

//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: upcomingFollowups.length,
//       itemBuilder: (context, index) {
//         var item = upcomingFollowups[index];
//         return (item.containsKey('name') &&
//                 item.containsKey('due_date') &&
//                 item.containsKey('lead_id') &&
//                 item.containsKey('task_id'))
//             ? UpcomingFollowupItem(
//                 name: item['name'],
//                 date: item['due_date'],
//                 vehicle: 'Discovery Sport',
//                 leadId: item['lead_id'],
//                 taskId: item['task_id'],
//                 isFavorite: item['favourite'] ?? false,
//                 fetchDashboardData: (){},
//               )
//             : ListTile(title: Text('Invalid data at index $index'));
//       },
//     );
//   }
// }

class FollowupsUpcoming extends StatefulWidget {
  final List<dynamic> upcomingFollowups;
  const FollowupsUpcoming({
    super.key,
    required this.upcomingFollowups,
  });

  @override
  State<FollowupsUpcoming> createState() => _FollowupsUpcomingState();
}

class _FollowupsUpcomingState extends State<FollowupsUpcoming> {
  @override
  void initState() {
    super.initState();
    // upcomingAppointments = widget.upcomingOpp;
    print('this is coming upcomingFollowups on page');
    print(widget.upcomingFollowups);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upcomingFollowups.isEmpty) {
      return Container(
        height: 250,
        child: const Center(child: Text('No upcoming followups available')),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.upcomingFollowups.length,
      itemBuilder: (context, index) {
        var item = widget.upcomingFollowups[index];
        return (item.containsKey('name') &&
                item.containsKey('due_date') &&
                item.containsKey('lead_id') &&
                item.containsKey('task_id'))
            ? UpcomingFollowupItem(
                name: item['name'],
                date: item['due_date'],
                vehicle: 'Discovery Sport',
                leadId: item['lead_id'],
                taskId: item['task_id'],
                isFavorite: item['favourite'] ?? false,
                fetchDashboardData: () {}, // No need to refresh data
              )
            : ListTile(title: Text('Invalid data at index $index'));
      },
    );
  }
}

// ---------------- INDIVIDUAL FOLLOWUP ITEM ----------------
class UpcomingFollowupItem extends StatefulWidget {
  final String name, date, vehicle, leadId, taskId;
  final bool isFavorite;
  final VoidCallback fetchDashboardData;

  const UpcomingFollowupItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.taskId,
    required this.isFavorite,
    required this.fetchDashboardData,
  });

  @override
  State<UpcomingFollowupItem> createState() => _UpcomingFollowupItemState();
}

class _UpcomingFollowupItemState extends State<UpcomingFollowupItem> {
  late bool isFav;
  String? leadId;
  @override
  void initState() {
    super.initState();
    leadId = widget.leadId;
    isFav = widget.isFavorite;
  }

  Future<void> _toggleFavorite() async {
    final token = await Storage.getToken();
    final url = Uri.parse(
        'https://api.smartassistapp.in/api/favourites/mark-fav/task/${widget.taskId}');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'taskId': widget.taskId, 'favourite': !isFav}),
      );

      if (response.statusCode == 200) {
        setState(() {
          isFav = !isFav;
        });
        widget.fetchDashboardData();
      } else {
        print('Failed to update favorite status: ${response.body}');
      }
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Slidable(
        endActionPane: const ActionPane(
          motion: StretchMotion(),
          children: [
            ReusableSlidableAction(
                onPressed: _phoneAction,
                backgroundColor: Colors.blue,
                icon: Icons.phone),
            ReusableSlidableAction(
                onPressed: _messageAction,
                backgroundColor: Colors.green,
                icon: Icons.message_rounded),
            ReusableSlidableAction(
                onPressed: _mailAction,
                backgroundColor: Colors.grey,
                icon: Icons.mail,
                foregroundColor: Colors.red),
          ],
        ),
        child: _buildFollowupCard(),
      ),
    );
  }

  Widget _buildFollowupCard() {
    return Container(
      padding: const EdgeInsets.all(10),
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
          // Icon and User Details in one row
          Row(
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
              const SizedBox(width: 8), // Spacing
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
            ],
          ),
          _buildNavigationButton(),
        ],
      ),
    );
  }

  // Widget _buildFollowupCard() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     decoration: BoxDecoration(
  //       color: AppColors.containerBg,
  //       borderRadius: BorderRadius.circular(10),
  //       border: const Border(
  //           left: BorderSide(
  //               width: 8.0, color: Color.fromARGB(255, 81, 223, 121))),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       // crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         IconButton(
  //           icon: Icon(isFav ? Icons.star_rounded : Icons.star_border_rounded,
  //               color: isFav ? Colors.amber : Colors.grey, size: 40),
  //           onPressed: _toggleFavorite,
  //         ),
  //         Row(
  //           children: [
  //             _buildUserDetails(),
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Row(
  //               children: [
  //                 _date(),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 _buildVerticalDivider(),
  //                 _buildCarModel(),
  //               ],
  //             )
  //           ],
  //         ),
  //         _buildNavigationButton(),
  //       ],
  //     ),
  //   );
  // }

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

}

// ---------------- REUSABLE SLIDABLE ACTION ----------------
class ReusableSlidableAction extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color? foregroundColor;

  const ReusableSlidableAction({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: (context) => onPressed(),
      child: Icon(icon, size: 30, color: Colors.white),
    );
  }
}

// ---------------- ACTION HANDLERS ----------------
void _phoneAction() => print("Phone action triggered");
void _messageAction() => print("Message action triggered");
void _mailAction() => print("Mail action triggered");
