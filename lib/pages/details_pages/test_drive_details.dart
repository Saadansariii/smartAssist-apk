import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Widget buildDetailRow(String imagePath, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Divider(color: Colors.grey.shade300, thickness: 1)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

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
              // Container(
              //   width: double.infinity,
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Column(
              //     children: [
              //       const CircleAvatar(
              //         radius: 40,
              //         backgroundImage: AssetImage('assets/profile.png'),
              //       ),
              //       const SizedBox(height: 10),
              //       const Text('Tira',
              //           style: TextStyle(
              //               fontSize: 20, fontWeight: FontWeight.bold)),
              //       const SizedBox(height: 20),
              //       buildDetailRow('assets/whatsappicon.png', 'WhatsApp Number',
              //           '367364746838'),
              //       buildDetailRow(
              //           'assets/mail.png', 'Email', 'Tira@gmail.com'),
              //       buildDetailRow(
              //           'assets/companybag.png', 'Company', 'Land Rover'),
              //       buildDetailRow('assets/location.png', 'Address',
              //           'Kanchpada, Malad West, India - 400064'),
              //       buildDetailRow(
              //           'assets/caricon.png', 'Car', 'Range Rover Evoque'),
              //       buildDetailRow(
              //           'assets/calandericon.png', 'Date', '2024-08-01'),
              //       buildDetailRow('assets/time.png', 'Time', '12:48'),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 30),

              // //////////////////////////////////////////

              Column(
                children: [
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
                    endChild: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
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
                  ),
                  const Timeline(
                    isFirst: true,
                    isLast: false,
                    icon: Icons.mail,
                    showIndicator: true,
                    startChild: Text(
                      '10:15 \nAm',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    endChild:
                        Text('Emails sent, including content, attachments'),
                  ),
                  // Text('10:15 \nAm'),
                  const Timeline(
                    isFirst: false,
                    isLast: true,
                    icon: Icons.phone,
                    showIndicator: true,
                    startChild: Text(
                      '10:15 \nAm',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    endChild: Text(
                        'Updated the quote over call, including content, attachments, and whether they were opened or clicked.'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
