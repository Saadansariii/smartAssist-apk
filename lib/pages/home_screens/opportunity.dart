import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_assist/pages/calenderPages/calender.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/widgets/home_btn.dart/bottom_btn_second.dart';
import 'package:smart_assist/widgets/home_btn.dart/threebtn.dart';
import 'package:google_fonts/google_fonts.dart';

class Opportunity extends StatefulWidget {
  const Opportunity({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OpportunityState createState() => _OpportunityState();
}

class _OpportunityState extends State<Opportunity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1380FE),
        title: Text(
          'Good morning Richard !',
          style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: Colors.white,
          )
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('one'),
            ),
            ListTile(
              title: Text('two'),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFE1EFFF),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(1, 4, 0, 4),
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Color(0xff767676),
                                  fontWeight: FontWeight.w400),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  // Open the endDrawer when the menu icon is tapped
                                  Scaffold.of(context).openEndDrawer();
                                },
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.grey,
                                ),
                              ),
                              suffixIcon:
                                  const Icon(Icons.mic, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Threebtn(),

              const BottomBtnSecond(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white, // Background color of the fixed area
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column doesn’t expand unnecessarily
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FontAwesomeIcons.magnifyingGlass),
                      // Image.asset('assets/Opportunity.png', height: 25, width: 30),
                      Text(
                        'Leads',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column doesn’t expand unnecessarily
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Opportunity()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.fireFlameCurved,
                        color: Colors.blue,
                      ),
                      // Image.asset('assets/Opportunity.png', height: 25, width: 30),
                      Text(
                        'Opportunity',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column doesn’t expand unnecessarily
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Calender()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FontAwesomeIcons.calendarDays),
                      // Image.asset('assets/Opportunity.png', height: 25, width: 30),
                      Text(
                        'Calendar',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                // Image.asset('assets/calender.png', height: 25, width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
