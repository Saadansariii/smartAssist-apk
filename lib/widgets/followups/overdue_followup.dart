import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';

class OverdueFollowup extends StatefulWidget {
  final List<dynamic> overdueeFollowups;
  const OverdueFollowup({super.key, required this.overdueeFollowups});

  @override
  State<OverdueFollowup> createState() => _OverdueFollowupState();
}

class _OverdueFollowupState extends State<OverdueFollowup> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print("widget.upcomingFollowups");
    print(widget.overdueeFollowups);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.overdueeFollowups.isEmpty) {
      return const Center(
        child: Text('No upcoming followups available'),
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

  const overdueeFollowupsItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.taskId,
  });

  @override
  State<overdueeFollowupsItem> createState() => _overdueeFollowupsItemState();
}

class _overdueeFollowupsItemState extends State<overdueeFollowupsItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            ReusableSlidableAction(
              onPressed: () => _phoneAction(),
              backgroundColor: Colors.blue,
              icon: Icons.phone,
            ),
            ReusableSlidableAction(
              onPressed: () => _messageAction(),
              backgroundColor: Colors.green,
              icon: Icons.message_rounded,
            ),
            ReusableSlidableAction(
              onPressed: () => _mailAction(),
              backgroundColor: const Color.fromARGB(255, 231, 225, 225),
              icon: Icons.mail,
              foregroundColor: Colors.red,
            ),
          ],
        ),
        child: SizedBox(
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 244, 244),
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                left: BorderSide(width: 8.0, color: Colors.red),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.star_rounded,
                    color: Colors.amberAccent, size: 40),
                _buildUserDetails(),
                _buildVerticalDivider(),
                _buildCarModel(),
                _buildNavigationButton(context, widget.leadId),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromARGB(255, 139, 138, 138)),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.blue, size: 14),
            const SizedBox(width: 10),
            Text(widget.date,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 20,
      width: 1,
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: Colors.grey))),
    );
  }

  Widget _buildCarModel() {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      child: Text(widget.vehicle,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)),
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
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: const Color(0xffD9D9D9),
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
