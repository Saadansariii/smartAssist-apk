import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/calenderPages/calender.dart';
import 'package:smart_assist/pages/navbar_page/app_setting.dart';
import 'package:smart_assist/pages/navbar_page/favorite.dart';
import 'package:smart_assist/pages/navbar_page/logout_page.dart';
import 'package:smart_assist/pages/home_screens/opportunity.dart';
import 'package:smart_assist/pages/notification/notification.dart';
import 'package:smart_assist/widgets/home_btn.dart/bottom_btn_second.dart';
import 'package:smart_assist/widgets/home_btn.dart/threebtn.dart';

class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key, });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1380FE),
        title: Text(
          'Good morning Richard!',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: TextField(
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
                                    hintStyle: GoogleFonts.montserrat(
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
                                              height: 270,
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
                                                                FavoritePage(leadId:  '',),
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
                      Threebtn(
                        leadId:'',
                      ),
                      const BottomBtnSecond(),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.blue),
            label: "Leads",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fireFlameCurved),
            label: "Opportunity",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendarDays),
            label: "Calendar",
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Opportunity(leadId:'')),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Calender()),
            );
          }
        },
      ),
    );
  }
}
