import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_assist/pages/details_pages/followups.dart';

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

  @override
  void initState() {
    super.initState();
    print("widget.upcomingFollowups hereeee");
    print(widget.upcomingOpp);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upcomingOpp.isEmpty) {
      return const Center(
        child: Text('No upcoming followups available'),
      );
    }
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.upcomingOpp.length,
            itemBuilder: (context, index) {
              var item = widget.upcomingOpp[index];
              if (item.containsKey('assigned_to') &&
                  item.containsKey('start_date') &&
                  item.containsKey('event_id')) {
                return UpcomingOppItem(
                  name: item['assigned_to'],
                  date: item['start_date'],
                  vehicle: 'Discovery Sport',
                  leadId: item['event_id'],
                );
              } else {
                return ListTile(title: Text('Invalid data at index $index'));
              }
            },
          );
  }
}

class UpcomingOppItem extends StatelessWidget {
  final String name;
  final String date;
  final String vehicle;
  final String leadId;

  const UpcomingOppItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
  });

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
                left: BorderSide(
                    width: 8.0, color: Color.fromARGB(255, 81, 223, 121)),
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
                _buildNavigationButton(context),
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
          name,
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
            Text(date,
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
      child: Text(vehicle,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FollowupsDetails())),
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
