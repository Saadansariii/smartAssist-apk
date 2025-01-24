import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/details_pages/test_drive_details.dart';
import 'package:smart_assist/pages/test_drive_pages/drive_start.dart';
import 'package:smart_assist/pages/test_drive_pages/verify_otp.dart';
import 'package:smart_assist/widgets/details/testdrive_details.dart';

class TestUpcoming extends StatelessWidget {
  const TestUpcoming({super.key});

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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DriveStart(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove padding
                    minimumSize: Size.zero, // Remove minimum size
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // Shrink tap target
                    backgroundColor:
                        Colors.transparent, // Transparent background
                  ),
                  child: Text(
                    'Start',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
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
                Image.asset('assets/star.png'),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rose Dean',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 139, 138, 138)),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.grey,
                        ),
                        Text('10:30 Am',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.grey)),
                      ],
                    )
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Discovery Sport',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          'Tomorrow',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [Image.asset('assets/arrowButton.png')],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
