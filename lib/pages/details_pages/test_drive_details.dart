import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screen.dart';
import 'package:smart_assist/pages/test_drive.dart/finish_drive.dart';
import 'package:smart_assist/widgets/details/testdrive_details.dart';
import 'package:smart_assist/widgets/details/timeline.dart';
import 'package:smart_assist/widgets/timeline/timeline_eight_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_five_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_four_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_nine_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_one_widget.dart';
import 'package:smart_assist/widgets/timeline/timeline_seven_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_six_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_ten_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_thee_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_two_wid.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TestDriveDetails extends StatefulWidget {
  const TestDriveDetails({super.key});

  @override
  State<TestDriveDetails> createState() => _TestDriveDetailsState();
}

class _TestDriveDetailsState extends State<TestDriveDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 235, 235),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Test Drive Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            TestdriveDetailsWidget(),
            const SizedBox(height: 30),
            // Second widget
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ 

                  TimelineTenWid(),
                  SizedBox(
                    height: 10,
                  ),

                  // timeline 2 Tira
                  TimelineNineWid(),
                  // 22oct
                  TimelineEightWid(),
                  // first column first
                  TimelineSevenWid(),
                  TimelineSixWid(),
                  TimelineFiveWid(),
                  // third
                  TimelineFourWid(),
// add
                  TimelineOneWidget(),
                  TimelineTwoWid(),
                  TimelineTheeWid()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
