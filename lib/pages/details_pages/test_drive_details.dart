import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screen.dart';
import 'package:smart_assist/pages/test_drive.dart/finish_drive.dart';
import 'package:smart_assist/widgets/details/testdrive_details.dart';
import 'package:smart_assist/widgets/details/timeline.dart';
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
                  // timelinen 1

                  TimelineTile(
                    alignment: TimelineAlign.start,
                    beforeLineStyle: const LineStyle(
                      color: Colors.transparent, // Remove the line
                      thickness: 0, // No thickness
                    ),
                    afterLineStyle: const LineStyle(
                      color: Colors.transparent, // Remove the line
                      thickness: 0, // No thickness
                    ),
                    indicatorStyle: const IndicatorStyle(
                      width: 0, // No indicator
                      height: 0, // No indicator
                      color: Colors
                          .transparent, // Transparent to ensure it's not visible
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'History',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  // timeline 2 Tira
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 239, 235, 235),
                        borderRadius: BorderRadius.circular(10)),
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.2, // Align the line properly
                      isFirst: false,
                      isLast: false,
                      beforeLineStyle: LineStyle(
                        color: Colors.transparent, // No line before
                        thickness: 2,
                      ),
                      afterLineStyle: LineStyle(
                        color: Colors.transparent, // No line after
                        thickness: 2,
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 30,
                        height: 30,
                        color: Colors.transparent, // No circle indicator
                      ),
                      startChild: Icon(Icons.person), // Icon as start child
                      endChild: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tira',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 117, 117, 117)),
                            ),
                            Text(
                              'By lily',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test Drive Completed',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.done,
                                  size: 14,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 22oct
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    beforeLineStyle: const LineStyle(
                      color: Colors.transparent, // Remove the line
                      thickness: 0, // No thickness
                    ),
                    afterLineStyle: const LineStyle(
                      color: Colors.transparent, // Remove the line
                      thickness: 0, // No thickness
                    ),
                    indicatorStyle: const IndicatorStyle(
                      width: 0, // No indicator
                      height: 0, // No indicator
                      color: Colors
                          .transparent, // Transparent to ensure it's not visible
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '22 OCT',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  // first column first
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25, // Adjust the line position
                    isFirst: true,
                    isLast: false,
                    beforeLineStyle: LineStyle(
                      color: Colors.blue, // Line color
                      thickness: 2, // Line thickness
                    ),
                    indicatorStyle: IndicatorStyle(
                      padding: EdgeInsets.only(left: 5),
                      width: 30,
                      height: 30,
                      color: Colors.red, // Indicator color
                      iconStyle: IconStyle(
                        iconData: Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                    startChild: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE7F2FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '10:15Am',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0), // Add padding for the gap
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  10), // This adds vertical space between startChild and endChild
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffE7F2FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Emails sent, including content, attachments.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25, // Adjust the line position
                    isFirst: false,
                    isLast: true,
                    beforeLineStyle: LineStyle(
                      color: Colors.blue, // Line color
                      thickness: 2, // Line thickness
                    ),
                    indicatorStyle: IndicatorStyle(
                      padding: EdgeInsets.only(left: 5),
                      width: 30,
                      height: 30,
                      color: Colors.lightGreen, // Indicator color
                      iconStyle: IconStyle(
                        iconData: Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    startChild: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF4FDEE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '10:15Am',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffF4FDEE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Emails sent, including content, attachments.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  TimelineTile(
                    alignment: TimelineAlign.start,
                    beforeLineStyle: const LineStyle(
                      color: Colors.transparent, // Remove the line
                      thickness: 0, // No thickness
                    ),
                    afterLineStyle: const LineStyle(
                      color: Colors.transparent, // Remove the line
                      thickness: 0, // No thickness
                    ),
                    indicatorStyle: const IndicatorStyle(
                      width: 0, // No indicator
                      height: 0, // No indicator
                      color: Colors
                          .transparent, // Transparent to ensure it's not visible
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '22 OCT',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  // third
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25, // Adjust alignment of the timeline line
                    isFirst: true,
                    isLast: false,
                    beforeLineStyle: const LineStyle(
                      color: Colors.blue, // Customize line color
                      thickness: 2, // Line thickness
                    ),
                    indicatorStyle: IndicatorStyle(
                        padding: EdgeInsets.only(left: 5),
                        // drawGap: true,
                        width: 30,
                        height: 30,
                        color: const Color.fromARGB(255, 50, 115, 168),
                        iconStyle: IconStyle(
                            iconData: Icons.car_crash, color: Colors.white)),
                    startChild: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE7F2FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '10:15Am',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0), // Horizontal padding for gap
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  10), // Adds vertical space between startChild and endChild
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffE7F2FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tira.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 109, 108, 108),
                                    ),
                                  ),
                                  Text(
                                    'By Lili.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Email Delivered: Proposal Sent.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),

                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25,
                    isFirst: false,
                    isLast: true,
                    beforeLineStyle: const LineStyle(
                      color: Colors.blue,
                      thickness: 2,
                    ),
                    indicatorStyle: IndicatorStyle(
                        padding: EdgeInsets.only(left: 5),
                        width: 30,
                        height: 30,
                        color: const Color.fromARGB(255, 50, 115, 168),
                        iconStyle: IconStyle(
                            iconData: Icons.car_crash, color: Colors.white)),
                    startChild: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F5F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '10:15Am',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0), // Horizontal padding for gap
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  10), // Adds vertical space between startChild and endChild
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffF8F5F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'October 22, 2024 \nLand Rover Defender 110 (2024).',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                // box
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Text('from:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(height: 3),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Kanchpada Mumbai',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const SizedBox(height: 1),
                                                  const Divider(
                                                      color: Colors.black,
                                                      thickness: 1),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Text('To:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(height: 3),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Marine lines',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(height: 1),
                                                  const Divider(
                                                      color: Colors.grey,
                                                      thickness: 1),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Text('Start time:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(height: 3),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    '11 : 55',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(height: 1),
                                                  const Divider(
                                                      color: Colors.grey,
                                                      thickness: 1),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Text('End time:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(height: 3),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    '00 : 00',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(height: 1),
                                                  const Divider(
                                                      color: Colors.grey,
                                                      thickness: 1),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Text('Total time:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(height: 3),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    '30 min',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(height: 1),
                                                  const Divider(
                                                      color: Colors.grey,
                                                      thickness: 1),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  'Test Drive 2:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 94, 94, 94),
                                  ),
                                ),
                                Text(
                                  'Car Model: [Make,Model,Year]',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 94, 94, 94),
                                  ),
                                ),
                                Text(
                                  'Dealership Location: [Dealership name and addresss]',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 94, 94, 94),
                                  ),
                                ),
                                Text(
                                  'feedback:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 94, 94, 94),
                                  ),
                                ),
                                Text(
                                  'Pros : the customer was highly impressed by the sleek and elegant design of the velar.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 94, 94, 94),
                                  ),
                                ),

                                Text(
                                  'Cons :They expressed concern that the low roofline might compromise headdroom.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 94, 94, 94),
                                  ),
                                ),

                                Text(
                                  'Decision:[interested/Not interested/Considering]',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 94, 94, 94),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
