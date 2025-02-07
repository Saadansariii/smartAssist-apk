import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';

// ---------------- FOLLOWUPS UPCOMING LIST ----------------
class FollowupsUpcoming extends StatefulWidget {
  final List<dynamic> upcomingFollowups; 
  const FollowupsUpcoming({super.key, required this.upcomingFollowups, });

  @override
  State<FollowupsUpcoming> createState() => _FollowupsUpcomingState();
}

class _FollowupsUpcomingState extends State<FollowupsUpcoming> {
  bool isLoading = false;
  List<dynamic> upcomingFollowups = [];

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
    
  }

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
        setState(() {
          upcomingFollowups = data['upcomingFollowups'];
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upcomingFollowups.isEmpty) {
      return const Center(child: Text('No upcoming followups available'));
    }
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
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
                      fetchDashboardData: fetchDashboardData,
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
