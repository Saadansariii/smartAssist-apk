import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';

// ---------------- appointment UPCOMING LIST ----------------
class OppUpcoming extends StatefulWidget {
  final List<dynamic> upcomingOpp;
  const OppUpcoming({
    super.key,
    required this.upcomingOpp,
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
    fetchDashboardData();
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
  //         upcomingAppointments = data['upcomingAppointments'];
  //       });
  //     } else {
  //       print("Failed to load data: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   }
  // }

  Future<void> fetchDashboardData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Full API Response: $data");

        if (data.containsKey('upcomingAppointments')) {
          print(
              "Upcoming Appointments Data: ${data['upcomingAppointments']}"); // Debug
        }

        setState(() {
          upcomingAppointments = data['upcomingAppointments'] ?? [];
          _showLoader = false;
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
        setState(() {
          _showLoader = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        _showLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoader) {
      return Container(
        height: 250,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (upcomingAppointments.isEmpty) {
      return Container(
        height: 250,
        child: const Center(child: Text('No upcoming Appointment available')),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: upcomingAppointments.length,
      itemBuilder: (context, index) {
        var item = upcomingAppointments[index];
        return (item.containsKey('assigned_to') &&
                item.containsKey('start_date') &&
                item.containsKey('lead_id') &&
                item.containsKey('event_id'))
            ? OppUpcomingItem(
                name: item['assigned_to'],
                date: item['start_date'],
                vehicle: 'Discovery Sport',
                leadId: item['lead_id'],
                eventId: item['event_id'],
                isFavorite: item['favourite'] ?? false,
                fetchDashboardData: fetchDashboardData,
              )
            : ListTile(title: Text('Invalid data at index $index'));
      },
    );
  }
}

// ---------------- INDIVIDUAL FOLLOWUP ITEM ----------------
class OppUpcomingItem extends StatefulWidget {
  final String name, date, vehicle, leadId, eventId;
  final bool isFavorite;
  final VoidCallback fetchDashboardData;

  const OppUpcomingItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.isFavorite,
    required this.fetchDashboardData,
    required this.eventId,
  });

  @override
  State<OppUpcomingItem> createState() => _OppUpcomingItemState();
}

class _OppUpcomingItemState extends State<OppUpcomingItem> {
  late bool isFav;

  @override
  void initState() {
    super.initState();

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
        body: jsonEncode({'taskId': widget.eventId, 'favourite': !isFav}),
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: const Border(
            left: BorderSide(
                width: 8.0, color: Color.fromARGB(255, 81, 223, 121))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(isFav ? Icons.star_rounded : Icons.star_border_rounded,
                color: isFav ? Colors.amber : Colors.grey, size: 40),
            onPressed: _toggleFavorite,
          ),
          _buildUserDetails(),
          _buildVerticalDivider(),
          _buildCarModel(),
          _buildNavigationButton(),
        ],
      ),
    );
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.blue, size: 14),
            const SizedBox(width: 5),
            Text(widget.date,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      // margin: const EdgeInsets.only(top: 20),
      height: 20,
      width: 1,
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: Colors.grey))),
    );
  }

  Widget _buildCarModel() {
    return Text(widget.vehicle,
        style: const TextStyle(fontSize: 12, color: Colors.grey));
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
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(30)),
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

