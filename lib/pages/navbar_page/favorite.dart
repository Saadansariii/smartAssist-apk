import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart'; 
import 'package:smart_assist/widgets/followups/overdue_followup.dart';
import 'package:smart_assist/widgets/followups/upcoming_row.dart';
import 'package:smart_assist/widgets/opp_follup.dart/overdue_opp.dart';
import 'package:smart_assist/widgets/opp_follup.dart/upcoming.dart';

class FavoritePage extends StatefulWidget {
  final String leadId;
  const FavoritePage({super.key, required this.leadId});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Widget currentWidgetOverdue1 = const OverdueFollowup(
    overdueeFollowups: [],
  );
  Widget currentWidgetOverdue2 = const OverdueOpp();
  Widget currentWidget1 = const OppFollUps();
  Widget currentWidget = FollowupsUpcoming(upcomingFollowups: [], leadId: '');
  Widget currentWidgetOverdue3 = const OverdueFollowup(
    overdueeFollowups: [],
  );
  int _upcommingButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Favorites',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlexibleButton(
                      title: 'All',
                      onPressed: () {
                        setState(() {
                          _upcommingButtonIndex = 0;
                        });
                      },
                      decoration: BoxDecoration(
                        border: _upcommingButtonIndex == 0
                            ? Border.all(color: Colors.blue)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      textStyle: GoogleFonts.poppins(
                        color: _upcommingButtonIndex == 0
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    FlexibleButton(
                        title: 'Followups',
                        onPressed: () {
                          setState(() {
                            _upcommingButtonIndex = 1;
                          });
                        },
                        decoration: BoxDecoration(
                          border: _upcommingButtonIndex == 1
                              ? Border.all(color: Colors.blue)
                              : Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        textStyle: GoogleFonts.poppins(
                            color: _upcommingButtonIndex == 1
                                ? Colors.blue
                                : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      width: 3,
                    ),
                    FlexibleButton(
                      title: 'Appointments',
                      onPressed: () {
                        setState(() {
                          _upcommingButtonIndex = 2;
                        });
                      },
                      decoration: BoxDecoration(
                        border: _upcommingButtonIndex == 2
                            ? Border.all(color: Colors.blue)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      textStyle: GoogleFonts.poppins(
                          color: _upcommingButtonIndex == 2
                              ? Colors.blue
                              : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    FlexibleButton(
                      title: 'Test Drive',
                      onPressed: () {
                        setState(() {
                          _upcommingButtonIndex = 3;
                        });
                      },
                      decoration: BoxDecoration(
                        border: _upcommingButtonIndex == 3
                            ? Border.all(color: Colors.blue)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      textStyle: GoogleFonts.poppins(
                          color: _upcommingButtonIndex == 3
                              ? Colors.blue
                              : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class FlexibleButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final BoxDecoration decoration;
  final TextStyle textStyle;

  const FlexibleButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.decoration,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: decoration,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0xffF3F9FF),
          padding: EdgeInsets.symmetric(horizontal: 10),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
