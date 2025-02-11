import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/calenderPages/calender.dart';
import 'package:smart_assist/pages/navbar_page/app_setting.dart';
import 'package:smart_assist/pages/navbar_page/favorite.dart';
import 'package:smart_assist/pages/navbar_page/leads.dart';
import 'package:smart_assist/pages/navbar_page/logout_page.dart';
import 'package:smart_assist/pages/home_screens/opportunity.dart';
import 'package:smart_assist/pages/notification/notification.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/widgets/home_btn.dart/bottom_btn_second.dart';
import 'package:smart_assist/widgets/home_btn.dart/threebtn.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String greeting;
  final String leadId;
  const HomeScreen({
    super.key,
    required this.greeting,
    required this.leadId,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  String? leadId;
  String greeting = '';
  List<dynamic> upcomingFollowups = [];
  List<dynamic> overdueFollowups = [];
  List<dynamic> upcomingAppointments = [];
  List<dynamic> overdueAppointments = [];
  //  List<dynamic> greeting = [];

  @override
  void initState() {
    super.initState();
    fetchDashboardData(); 
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDashboardData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Decoded Data: $data');
        setState(() {
          upcomingFollowups = data['upcomingFollowups'];
          overdueFollowups = data['overdueFollowups'];
          overdueAppointments = data['overdueAppointments'];
          upcomingAppointments = data['upcomingAppointments'];
          greeting =
              data.containsKey('greetings') && data['greetings'] is String
                  ? data['greetings']
                  : 'Welcome!';

          print(data['greetings']);
          if (upcomingFollowups.isNotEmpty) {
            leadId = upcomingFollowups[0]['lead_id'];
          }
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1380FE),
        title: Text(
          ' $greeting',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationPage(
                            leadId: '',
                          )));
            },
            icon: const Icon(Icons.notifications),
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: fetchData,
          child: isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Show loader when refreshing
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Search Field
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFE1EFFF),
                                    hintText: 'Search',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: const Color(0xff767676),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          builder: (context) {
                                            return Container(
                                              padding: const EdgeInsets.all(16),
                                              height: 320,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.person_outline,
                                                      size: 28,
                                                    ),
                                                    title: Text(
                                                      'Profile',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      size: 28,
                                                    ),
                                                    title: Text(
                                                      'Favorites',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FavoritePage(
                                                            leadId: '',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.search,
                                                      size: 28,
                                                    ),
                                                    title: Text(
                                                      'Leads',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              LeadsAll(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.settings_outlined,
                                                      size: 28,
                                                    ),
                                                    title: Text(
                                                      'App Settings',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AppSetting(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.logout_outlined,
                                                      size: 28,
                                                    ),
                                                    title: Text(
                                                      'Logout',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LogoutPage(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.menu,
                                        color: Colors.grey,
                                        size: 30,
                                        // weight: 500,
                                      ),
                                    ),
                                    suffixIcon: const Icon(Icons.mic,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Threebtn(
                        leadId: leadId ?? '',
                        upcomingFollowups: upcomingFollowups,
                        overdueFollowups: overdueFollowups,
                        upcomingAppointments: upcomingAppointments,
                        overdueAppointments: overdueAppointments,
                      ),
                      const BottomBtnSecond(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
