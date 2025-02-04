import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedButtonIndex = 0;
  List<dynamic> notifications = [];
  final List<String> categories = [
    'All',
    'Lead',
    'Opportunity',
    'Meeting',
    'Test Drive',
    'Showroom Appointment',
    'Call',
    'Provide Quotation',
    'Send Email',
    'Vehicle Selection',
    'Send SMS'
  ];

  Future<void> fetchNotifications({String? category}) async {
    final token = await Storage.getToken();
    String url = 'https://api.smartassistapp.in/api/users/notifications/all';
    if (category != null && category != 'All') {
      url += '?category=$category';
    }
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('this is the current url ${url}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          notifications = data['rows'];
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Widget _buildButton(String title, int index) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: _selectedButtonIndex == index
            ? Border.all(color: Colors.blue)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xffF3F9FF),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          setState(() {
            _selectedButtonIndex = index;
          });
          fetchNotifications(category: categories[index]);
        },
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: _selectedButtonIndex == index ? Colors.blue : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(categories.length, (index) {
              return _buildButton(categories[index], index);
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Notification',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        semanticContainer: false,
                        borderOnForeground: false,
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: notification['read']
                                ? Colors.green
                                : Colors.grey,
                            size: 10,
                          ),
                          title: Text(
                            notification['title'] ?? 'No Title',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          subtitle: Text(
                            notification['body'] ?? '',
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    // Divider added after each list item
                    Divider(
                      thickness: 0.1,
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
