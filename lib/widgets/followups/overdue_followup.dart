import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart';

class OverdueFollowup extends StatefulWidget {
  final List<dynamic> overdueeFollowups;
  const OverdueFollowup({super.key, required this.overdueeFollowups});

  @override
  State<OverdueFollowup> createState() => _OverdueFollowupState();
}

class _OverdueFollowupState extends State<OverdueFollowup> {
  bool isLoading = false;
  List<dynamic> overdueFollowups = [];

  @override
  void initState() {
    super.initState();
    print("widget.upcomingFollowups");
    print(widget.overdueeFollowups);
    // fetchDashboardData();
  }

  // Future<void> fetchDashboardData() async {
  //   final token = await Storage.getToken();
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json'
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       setState(() {
  //         overdueFollowups = data['overdueFollowups'];
  //       });
  //     } else {
  //       print("Failed to load data: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.overdueeFollowups.isEmpty) {
      return SizedBox(
        height: 240,
        child: const Center(child: Text('No overdue followups available')),
      );
    }
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.overdueeFollowups.length,
            itemBuilder: (context, index) {
              var item = widget.overdueeFollowups[index];
              if (item.containsKey('name') &&
                  item.containsKey('due_date') &&
                  item.containsKey('lead_id') &&
                  item.containsKey('task_id')) {
                return overdueeFollowupsItem(
                  name: item['name'],
                  date: item['due_date'],
                  vehicle: 'Discovery Sport',
                  taskId: item['task_id'],
                  leadId: item['lead_id'],
                  isFavorite: item['favourite'] ?? false,
                  fetchDashboardData: () {},
                );
              } else {
                return ListTile(title: Text('Invalid data at index $index'));
              }
            },
          );
  }
}

class overdueeFollowupsItem extends StatefulWidget {
  final String name;
  final String date;
  final String vehicle;
  final String leadId;
  final String taskId;
  final bool isFavorite;
  final VoidCallback fetchDashboardData;

  const overdueeFollowupsItem({
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
  State<overdueeFollowupsItem> createState() => _overdueeFollowupsItemState();
}

class _overdueeFollowupsItemState extends State<overdueeFollowupsItem> {
  late bool isFav;
  @override
  void initState() {
    super.initState();
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
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'taskId': widget.taskId, 'favourite': !isFav}),
      );

      if (response.statusCode == 200) {
        print('this is the url ${url}');
        setState(() {
          isFav = !isFav;
        });
      } else {
        print('Failed to update favorite status: ${response.body}');
        print('this is the url ${url}');
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
        child: _buildOverdueCard(),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
  //     child: Slidable(
  //       endActionPane: ActionPane(
  //         motion: const StretchMotion(),
  //         children: [
  //           ReusableSlidableAction(
  //             onPressed: () => _phoneAction(),
  //             backgroundColor: Colors.blue,
  //             icon: Icons.phone,
  //           ),
  //           ReusableSlidableAction(
  //             onPressed: () => _messageAction(),
  //             backgroundColor: Colors.green,
  //             icon: Icons.message_rounded,
  //           ),
  //           ReusableSlidableAction(
  //             onPressed: () => _mailAction(),
  //             backgroundColor: const Color.fromARGB(255, 231, 225, 225),
  //             icon: Icons.mail,
  //             foregroundColor: Colors.red,
  //           ),
  //         ],
  //       ),
  //       child: _buildOverdueCard(),
  //       // child: SizedBox(
  //       //   height: 80,
  //       //   child: Container(
  //       //     decoration: BoxDecoration(
  //       //       color: const Color.fromARGB(255, 245, 244, 244),
  //       //       borderRadius: BorderRadius.circular(10),
  //       //       border: const Border(
  //       //         left: BorderSide(width: 8.0, color: Colors.red),
  //       //       ),
  //       //     ),
  //       //     child: Row(
  //       //       crossAxisAlignment: CrossAxisAlignment.center,
  //       //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       //       children: [
  //       //         IconButton(
  //       //           icon: Icon(
  //       //             isFav ? Icons.star_rounded : Icons.star_border_rounded,
  //       //             color: isFav ? Colors.amber : AppColors.starBorderColor,
  //       //             size: 40,
  //       //           ),
  //       //           onPressed: _toggleFavorite, // Call API on tap
  //       //         ),
  //       //         Column(
  //       //           crossAxisAlignment: CrossAxisAlignment.start,
  //       //           children: [
  //       //             _buildUserDetails(),
  //       //              const SizedBox(height: 4),
  //       //           ],
  //       //         ),
  //       //         _date(),
  //       //         _buildVerticalDivider(),
  //       //         _buildCarModel(),
  //       //         _buildNavigationButton(context, widget.leadId),
  //       //       ],
  //       //     ),
  //       //   ),
  //       // ),
  //     ),
  //   );
  // }

  Widget _buildOverdueCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.containerBg,
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(width: 8.0, color: AppColors.sideRed),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Ensures vertical centering
        children: [
          // Star Icon - Centered
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

          // User Details (Aligned to Left)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserDetails(),
                const SizedBox(height: 4), // Spacing between name and details
                Row(
                  children: [
                    _date(),
                    const SizedBox(
                        width: 8), // Add spacing between date and divider
                    _buildVerticalDivider(20),
                    const SizedBox(
                        width: 8), // Add spacing between divider and car model
                    _buildCarModel(),
                  ],
                ),
              ],
            ),
          ),

          // Arrow Button - Centered
          _buildNavigationButton(context, widget.leadId),
        ],
      ),
    );
  }

  // Widget _buildUserDetails() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         widget.name,
  //         style: GoogleFonts.poppins(
  //             fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
  //       ),
  //       const SizedBox(height: 5),
  //       Row(
  //         children: [
  //           const Icon(Icons.phone, color: Colors.blue, size: 14),
  //           const SizedBox(width: 10),
  //           Text(widget.date,
  //               style: const TextStyle(fontSize: 12, color: Colors.grey)),
  //         ],
  //       ),
  //     ],
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
        // const SizedBox(height: 5),
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

  // Widget _buildVerticalDivider() {
  //   return Container(
  //     height: 15,
  //     width: 1,
  //     decoration: const BoxDecoration(
  //         border: Border(right: BorderSide(color: AppColors.fontColor))),
  //   );
  // }

  // Widget _buildCarModel() {
  //   return Text(widget.vehicle,
  //       style: const TextStyle(fontSize: 10, color: AppColors.fontColor));
  // }

  Widget _buildVerticalDivider(double height) {
    return Container(
      height: height,
      width: 1.5,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.fontColor)),
      ),
    );
  }

  Widget _buildCarModel() {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxWidth: 100), // Adjust width as needed
      child: Text(
        widget.vehicle,
        style: GoogleFonts.poppins(fontSize: 10, color: AppColors.fontColor),
        overflow: TextOverflow.visible, // Allow text wrapping
        softWrap: true, // Enable wrapping
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String leadId) {
    return GestureDetector(
      onTap: () {
        if (leadId.isNotEmpty) {
          print("Navigating with leadId: $leadId");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FollowupsDetails(leadId: widget.leadId),
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
        child: const Icon(Icons.arrow_forward_ios_sharp,
            size: 25, color: Colors.white),
      ),
    );
  }
}

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          )
        ],
      ),
      onPressed: (context) => onPressed(),
    );
  }
}

void _phoneAction() {
  print("Phone action triggered");
}

void _messageAction() {
  print("Message action triggered");
}

void _mailAction() {
  print("Mail action triggered");
}
