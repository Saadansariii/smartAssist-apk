import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/details_pages/followups.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (context) {
              print('Phone action pressed');
            },
            backgroundColor: Colors.blue, // Background color of the action
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone, // Custom icon
                  color: Colors.white, // White icon color
                  size: 30, // Adjust size as needed
                ),
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (context) {
              print('Phone action pressed');
            },
            backgroundColor: Colors.green, // Background color of the action
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message, // Custom icon
                  color: Colors.white, // White icon color
                  size: 30, // Adjust size as needed
                ),
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (context) {
              print('Phone action pressed');
            },
            backgroundColor: const Color.fromARGB(
                255, 231, 225, 225), // Background color of the action
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mail, // Custom icon
                  color: Colors.white, // White icon color
                  size: 30, // Adjust size as needed
                ),
              ],
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 245, 244, 244), // Background color for the content
              borderRadius:
                  BorderRadius.circular(10), // Optional rounded corners
              border: const Border(
                left: BorderSide(
                  width: 8.0, // Left border width
                  color: Color.fromARGB(255, 81, 223, 121), // Left border color
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Image.asset('assets/star.png'),
                Icon(
                  Icons.star_rounded,
                  color: Colors.amberAccent,
                  size: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beth Ford',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 139, 138, 138)),
                    ),
                    // Divider(
                    //   color: Colors.amberAccent,
                    //   thickness: 1,
                    //   endIndent: 10,
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FontAwesomeIcons.phoneVolume,
                          color: Colors.blue,
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Today 3pm',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 20,
                        width: 1,
                        decoration: BoxDecoration(
                            border:
                                Border(right: BorderSide(color: Colors.grey)))),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Discovery Sport',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const FollowupsDetails()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 25,
                          color: Colors.white,
                          weight: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDismissed() {}
}
