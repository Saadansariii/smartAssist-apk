import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';

// ---------------- appointment UPCOMING LIST ----------------
class OppUpcoming extends StatefulWidget {
  final List<dynamic> upcomingOpp;
  final bool isNested;
  const OppUpcoming({
    super.key,
    required this.upcomingOpp,
    required this.isNested,
  });

  @override
  State<OppUpcoming> createState() => _OppUpcomingState();
}

class _OppUpcomingState extends State<OppUpcoming> {
  bool isLoading = false;

  bool _showLoader = true;
  List<dynamic> upcomingAppointments = [];

  @override
  void initState() {
    super.initState();
    // fetchDashboardData();
    upcomingAppointments = widget.upcomingOpp;
    print('this is widget.upcoming appointmnet');
    print(widget.upcomingOpp);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upcomingOpp.isEmpty) {
      return Container(
        height: 250,
        child: const Center(child: Text('No upcoming Appointment available')),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.isNested
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      itemCount: upcomingAppointments.length,
      itemBuilder: (context, index) {
        var item = widget.upcomingOpp[index];
        return (item.containsKey('assigned_to') &&
                item.containsKey('start_date') &&
                item.containsKey('lead_id') &&
                item.containsKey('event_id'))
            ? OppUpcomingItem(
                key: ValueKey(item['event_id']),
                name: item['name'] ?? 'No Name',
                date: item['start_date'],
                vehicle: 'Discovery Sport',
                time: item['start_time'],
                leadId: item['lead_id'],
                eventId: item['event_id'],
                isFavorite: item['favourite'] ?? false,
                fetchDashboardData: () {},
              )
            : ListTile(title: Text('Invalid data at index $index'));
      },
    );
  }
}

// ---------------- INDIVIDUAL FOLLOWUP ITEM ----------------
class OppUpcomingItem extends StatefulWidget {
  final String name, date, vehicle, leadId, eventId, time;
  final bool isFavorite;
  final VoidCallback fetchDashboardData;

  const OppUpcomingItem(
      {super.key,
      required this.name,
      required this.date,
      required this.vehicle,
      required this.leadId,
      required this.isFavorite,
      required this.fetchDashboardData,
      required this.eventId,
      required this.time});

  @override
  State<OppUpcomingItem> createState() => _OppUpcomingItemState();
}

class _OppUpcomingItemState extends State<OppUpcomingItem> {
  late bool isFav;
  String? leadId;
  @override
  void initState() {
    super.initState();
    leadId = widget.leadId;
    print('eventid');
    print(widget.eventId);
    isFav = widget.isFavorite;
  }

  Future<void> _toggleFavorite() async {
    final token = await Storage.getToken();
    final url = Uri.parse(
        'https://api.smartassistapp.in/api/favourites/mark-fav/event/${widget.eventId}');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'eventId': widget.eventId, 'favourite': !isFav}),
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
            left: BorderSide(width: 8.0, color: AppColors.sideGreen)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(isFav ? Icons.star_rounded : Icons.star_border_rounded,
                color: isFav
                    ? AppColors.starColorsYellow
                    : AppColors.starBorderColor,
                size: 40),
            onPressed: _toggleFavorite,
          ),
          // _buildUserDetails(),
          // _buildVerticalDivider(),
          // _buildCarModel(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildUserDetails(),
                    const SizedBox(width: 8),
                    _buildVerticalDivider(20),
                    const SizedBox(width: 8),
                    _buildCarModel(),
                  ],
                ),
                const SizedBox(
                    height: 4), // Spacing between user details and date-car
                Row(
                  children: [
                    _date(),
                    const SizedBox(width: 8),
                    _time(),
                  ],
                ),
              ],
            ),
          ),

          _buildNavigationButton(context, widget.leadId),
        ],
      ),
    );
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: GoogleFonts.poppins(
              color: AppColors.fontColor,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ],
    );
  }

  Widget _time() {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(widget.time);
    String formattedTime = DateFormat("h:mm a").format(parsedTime);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.access_time, color: Colors.grey, size: 14),
        const SizedBox(width: 4),
        Text(formattedTime,
            style: GoogleFonts.poppins(
                color: AppColors.fontColor,
                fontWeight: FontWeight.w400,
                fontSize: 12)),
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
      // margin: const EdgeInsets.only(top: 20),
      height: height,
      width: 1.5,
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: AppColors.fontColor))),
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
              builder: (context) => FollowupsDetails(leadId: leadId),
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


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:smart_assist/pages/details_pages/appointment/appointment_upcoming.dart';
// import 'package:smart_assist/pages/details_pages/followups/followups.dart';

// class OppUpcoming extends StatefulWidget {
//   final List<dynamic> upcomingOpp;
//   const OppUpcoming({
//     super.key,
//     required this.upcomingOpp,
//   });

//   @override
//   State<OppUpcoming> createState() => _OppUpcomingState();
// }

// class _OppUpcomingState extends State<OppUpcoming> {
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     print("widget.upcomingFollowups hereeee");
//     print(widget.upcomingOpp);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.upcomingOpp.isEmpty) {
//       return const Center(
//         child: Text('No upcoming followups available'),
//       );
//     }
//     return isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : ListView.builder(
//             shrinkWrap: true,
//             itemCount: widget.upcomingOpp.length,
//             itemBuilder: (context, index) {
//               var item = widget.upcomingOpp[index];
//               if (item.containsKey('assigned_to') &&
//                   item.containsKey('start_date') &&
//                   item.containsKey('lead_id') &&
//                   item.containsKey('event_id')) {
//                 return UpcomingOppItem(
//                   name: item['assigned_to'],
//                   date: item['start_date'],
//                   vehicle: 'Discovery Sport',
//                   leadId: item['lead_id'],
//                   eventId: item['event_id'],
//                 );
//               } else {
//                 return ListTile(title: Text('Invalid data at index $index'));
//               }
//             },
//           );
//   }
// }

// class UpcomingOppItem extends StatefulWidget {
//   final String name;
//   final String date;
//   final String vehicle;
//   final String leadId;
//   final String eventId;

//   const UpcomingOppItem({
//     super.key,
//     required this.name,
//     required this.date,
//     required this.vehicle,
//     required this.eventId,
//     required this.leadId,
//   });

//   @override
//   State<UpcomingOppItem> createState() => _UpcomingOppItemState();
// }

// class _UpcomingOppItemState extends State<UpcomingOppItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: const StretchMotion(),
//           children: [
//             ReusableSlidableAction(
//               onPressed: () => _phoneAction(),
//               backgroundColor: Colors.blue,
//               icon: Icons.phone,
//             ),
//             ReusableSlidableAction(
//               onPressed: () => _messageAction(),
//               backgroundColor: Colors.green,
//               icon: Icons.message_rounded,
//             ),
//             ReusableSlidableAction(
//               onPressed: () => _mailAction(),
//               backgroundColor: const Color.fromARGB(255, 231, 225, 225),
//               icon: Icons.mail,
//               foregroundColor: Colors.red,
//             ),
//           ],
//         ),
//         child: SizedBox(
//           height: 80,
//           child: Container(
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 245, 244, 244),
//               borderRadius: BorderRadius.circular(10),
//               border: const Border(
//                 left: BorderSide(
//                     width: 8.0, color: Color.fromARGB(255, 81, 223, 121)),
//               ),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 const Icon(Icons.star_rounded,
//                     color: Colors.amberAccent, size: 40),
//                 _buildUserDetails(),
//                 _buildVerticalDivider(),
//                 _buildCarModel(),
//                 _buildNavigationButton(context, widget.leadId),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserDetails() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.name,
//           style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: Color.fromARGB(255, 139, 138, 138)),
//         ),
//         const SizedBox(height: 5),
//         Row(
//           children: [
//             const Icon(Icons.phone, color: Colors.blue, size: 14),
//             const SizedBox(width: 10),
//             Text(widget.date,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildVerticalDivider() {
//     return Container(
//       margin: const EdgeInsets.only(top: 20),
//       height: 20,
//       width: 1,
//       decoration: const BoxDecoration(
//           border: Border(right: BorderSide(color: Colors.grey))),
//     );
//   }

//   Widget _buildCarModel() {
//     return Container(
//       margin: const EdgeInsets.only(top: 22),
//       child: Text(widget.vehicle,
//           style: const TextStyle(
//               fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)),
//     );
//   }

//   Widget _buildNavigationButton(BuildContext context, String leadId) {
//     return GestureDetector(
//       onTap: () {
//         if (leadId.isNotEmpty) {
//           print("Navigating with leadId: $leadId");
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AppointmentUpcoming(leadId: leadId),
//             ),
//           );
//         } else {
//           print("Invalid leadId");
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//             color: const Color(0xffD9D9D9),
//             borderRadius: BorderRadius.circular(30)),
//         child: const Icon(Icons.arrow_forward_ios_sharp,
//             size: 25, color: Colors.white),
//       ),
//     );
//   }
// }

// class ReusableSlidableAction extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final IconData icon;
//   final Color? foregroundColor;

//   const ReusableSlidableAction({
//     super.key,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.icon,
//     this.foregroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomSlidableAction(
//       backgroundColor: backgroundColor,
//       foregroundColor: foregroundColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 30,
//             color: Colors.white,
//           )
//         ],
//       ),
//       onPressed: (context) => onPressed(),
//     );
//   }
// }

// void _phoneAction() {
//   print("Phone action triggered");
// }

// void _messageAction() {
//   print("Message action triggered");
// }

// void _mailAction() {
//   print("Mail action triggered");
// }

