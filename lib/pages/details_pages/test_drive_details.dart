import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/test_drive.dart/finish_drive.dart';
import 'package:smart_assist/widgets/details/timeline.dart';
import 'package:smart_assist/widgets/details/timelinetext.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TestDriveDetails extends StatefulWidget {
  const TestDriveDetails({super.key});

  @override
  State<TestDriveDetails> createState() => _TestDriveDetailsState();
}

class _TestDriveDetailsState extends State<TestDriveDetails> {
  // List of details to iterate over
  final List<Map<String, String>> details = [
    {
      'image': 'assets/whatsappicon.png',
      'title': 'WhatsApp Number',
      'subtitle': '367364746838'
    },
    {
      'image': 'assets/mail.png',
      'title': 'Email',
      'subtitle': 'Tira@gmail.com'
    },
    {
      'image': 'assets/companybag.png',
      'title': 'Company',
      'subtitle': 'Land Rover'
    },
    {
      'image': 'assets/location.png',
      'title': 'Address',
      'subtitle': 'Kanchpada, Malad West, India - 400064'
    },
    {
      'image': 'assets/caricon.png',
      'title': 'Car',
      'subtitle': 'Range Rover Evoque'
    },
    {
      'image': 'assets/calandericon.png',
      'title': 'Date',
      'subtitle': '2024-08-01'
    },
    {'image': 'assets/time.png', 'title': 'Time', 'subtitle': '12:48'},
  ];

  Widget buildDetailRow(
      String imagePath, String title, String subtitle, bool isLast) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 30, height: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0x8F423F3F))),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 1),
                if (!isLast)
                  const Divider(
                      color: Color.fromARGB(255, 231, 230, 230), thickness: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 235, 235),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FinishDrive()));
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        title: const Text('Test Drive Details',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                    const SizedBox(height: 10),
                    Text('Tira',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2E2E30))),
                    // Iterate over the details list and pass the correct 'isLast' value
                    for (int i = 0; i < details.length; i++)
                      buildDetailRow(
                        details[i]['image']!,
                        details[i]['title']!,
                        details[i]['subtitle']!,
                        i == details.length - 1, // Last item check
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Timeline(
                      isFirst: false,
                      isLast: false,
                      showIndicator: false,
                      showBeforeLine: false,
                      startChild: Text(''),
                      endChild: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'History',
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                  Timeline(
                    isFirst: false,
                    isLast: false,
                    showIndicator: false,
                    showBeforeLine: false,
                    startChild: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '26\noct',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    endChild: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 227, 223, 223),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 111, 107, 107),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  size: 36,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tira',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(' 1 day left'),
                                )
                              ],
                            ),
                            Column(
                              children: [Text('By Lily')],
                            ),
                            Row(
                              children: [
                                Text('Test Drive Completed'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.done)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Timeline(
                    isFirst: true,
                    isLast: false,
                    icon: Icons.mail,
                    showIndicator: true,
                    startChild: Text(
                      '10:15 \nAm',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    endChild:
                        Text('Emails sent, including content, attachments'),
                  ),

                  Timeline(
                    isFirst: false,
                    isLast: true,
                    icon: Icons.phone,
                    showIndicator: true,
                    startChild: Text(
                      '10:15 \nAm',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    endChild: Text(
                        'Updated the quote over call, including content, attachments, and whether they were opened or clicked.'),
                  ),

                  // second

                  Timeline(
                    isFirst: false,
                    isLast: false,
                    showIndicator: false,
                    showBeforeLine: false,
                    startChild: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '22\noct',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    endChild: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 227, 223, 223),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 111, 107, 107),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  size: 36,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tira',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text('16oct'),
                                )
                              ],
                            ),
                            Column(
                              children: [Text('By Lily')],
                            ),
                            Row(
                              children: [
                                Text('Email Delivered : Proposal Sent',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // second one

                  const Timeline(
                    isFirst: true,
                    isLast: false,
                    icon: Icons.mail,
                    showIndicator: true,
                    startChild: Text(
                      '10:15 \nAm',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    endChild:
                        Text('Emails sent, including content, attachments'),
                  ),

                  Timeline(
                    isFirst: false,
                    isLast: false,
                    showBeforeLine: true,
                    icon: Icons.phone,
                    showIndicator: true,
                    startChild: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        '10:15\nAm',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    endChild: Text(
                        'Updated the quote over call, including content, attachments, and whether they were opened or clicked.'),
                  ),
                ],
              )

              // Additional widgets here if needed
            ],
          ),
        ),
      ),
    );
  }
}
