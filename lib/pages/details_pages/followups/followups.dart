import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/appointment_popup.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_followups/create_Followups_popups.dart';
import 'package:smart_assist/widgets/leads_details_popup/create_appointment.dart';
import 'package:smart_assist/widgets/leads_details_popup/create_followups.dart';
import 'package:smart_assist/widgets/timeline/timeline_seven_wid.dart';

class FollowupsDetails extends StatefulWidget {
  final String leadId;
  const FollowupsDetails({super.key, required this.leadId});

  @override
  State<FollowupsDetails> createState() => _FollowupsDetailsState();
}

class _FollowupsDetailsState extends State<FollowupsDetails> {
  // Placeholder data
  String mobile = 'Loading...';
  String email = 'Loading...';
  String status = 'Loading...';
  String company = 'Loading...';
  String address = 'Loading...';
  String lead_owner = 'Loading....';

  // fetchevent data

  List<String> subjectList = [];
  List<String> priorityList = [];
  List<String> startTimeList = [];
  List<String> endTimeList = [];
  List<String> startDateList = [];

  // dropdown
  final Widget _createFollowups = const LeadsCreateFollowup();
  final Widget _createAppoinment = const CreateAppointment();

  @override
  void initState() {
    super.initState();
    fetchSingleIdData(widget.leadId);
    fetchSingleEvent(widget.leadId);
  }

  Future<void> fetchSingleIdData(String leadId) async {
    try {
      final leadData = await LeadsSrv.singleFollowupsById(leadId);
      setState(() {
        mobile = leadData['mobile'] ?? 'N/A';
        email = leadData['email'] ?? 'N/A';
        status = leadData['status'] ?? 'N/A';
        company = leadData['brand'] ?? 'N/A';
        address = leadData['address'] ?? 'N/A';
        lead_owner = leadData['lead_owner'] ?? 'N/A';
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Future<void> fetchSingleEvent(String leadId) async {
  //   try {
  //     final List<Map<String, dynamic>> events =
  //         await LeadsSrv.singleEventById(leadId);

  //     setState(() {
  //       if (events.isNotEmpty) {
  //         allEvents = events;

  //         // Initialize lists to store event data
  //         subjectList = [];
  //         priorityList = [];
  //         startTimeList = [];
  //         endTimeList = [];
  //         startDateList = [];

  //         // Loop through all events and store their details
  //         for (var event in events) {
  //           subjectList.add(event['subject'] ?? 'N/A');
  //           priorityList.add(event['priority'] ?? 'N/A');
  //           startTimeList.add(_formatTime(
  //               event['start_time'])); // Convert time to 12-hour format
  //           endTimeList.add(_formatTime(event['end_time']));
  //           startDateList.add(event['start_date'] ?? 'N/A');
  //         }
  //       } else {
  //         print("No events available.");
  //       }
  //     });
  //   } catch (e) {
  //     print('Error Fetching data: $e');
  //   }
  // }
  List<Map<String, dynamic>> allEvents = [];

  Future<void> fetchSingleEvent(String leadId) async {
    try {
      // Fetch API response
      final List<Map<String, dynamic>> events =
          await LeadsSrv.singleEventById(leadId);

      setState(() {
        allEvents = events;

        // Initialize lists to store event data
        subjectList = [];
        priorityList = [];
        startTimeList = [];
        endTimeList = [];
        startDateList = [];

        // Loop through all events and store their details
        for (var event in events) {
          subjectList.add(event['subject'] ?? 'N/A');
          priorityList.add(event['priority'] ?? 'N/A');
          startTimeList.add(_formatTime(event['start_time']));
          endTimeList.add(_formatTime(event['end_time']));
          startDateList.add(event['start_date'] ?? 'N/A');
        }
      });
    } catch (e) {
      print('Error Fetching data: $e');
    }
  }

  // ✅ Function to Convert 24-hour Time to 12-hour Format
  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return 'N/A';

    try {
      DateTime parsedTime = DateFormat("HH:mm").parse(time);
      return DateFormat("hh:mm").format(parsedTime);
    } catch (e) {
      print("Error formatting time: $e");
      return 'Invalid Time';
    }
  }

  // Helper method to build ContactRow widget
  Widget _buildContactRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ContactRow(
      icon: icon,
      title: title,
      subtitle: subtitle,
      taskId: widget.leadId,
      containerBgColor: containerColors[title] ?? Colors.grey.shade200,
      iconColor: iconColors[title] ?? Colors.black, // Pass custom icon color
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F2F2),
        title: Text(
          'Leads Details',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 134, 134, 134),
          ),
        ),
        // actions: [
        //   Align(
        //     child: IconButton(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.add,
        //           size: 30,
        //         )),
        //   )
        // ],
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await showMenu<String>(
                    context: context,
                    position: const RelativeRect.fromLTRB(70, 90, 30, 100),
                    items: [
                      PopupMenuItem<String>(
                        height: 20,
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: _createFollowups,
                                );
                              },
                            );
                          });
                        },
                        value: 'followup',
                        child: Center(
                          child: Text(
                            'Create Followups',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem<String>(
                        height: 20,
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: _createAppoinment,
                                  // Appointment modal
                                );
                              },
                            );
                          });
                        },
                        value: 'appointment',
                        child: Center(
                          child: Text(
                            'Create Appointment',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                  if (result != null) {
                    print('Selected: $result');
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Icon(Icons.add, size: 30),
                ),
              ),
            ],
          ),
        ],

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Main Container with Flexbox Layout
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left Side - Contact Details
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildContactRow(
                              icon: Icons.phone,
                              title: 'Phone Number',
                              subtitle: mobile,
                            ),
                            _buildContactRow(
                              icon: Icons.email,
                              title: 'Email',
                              subtitle: email,
                            ),
                            _buildContactRow(
                              icon: Icons.local_post_office_outlined,
                              title: 'Company',
                              subtitle: status,
                            ),
                            _buildContactRow(
                              icon: Icons.location_on,
                              title: 'Address',
                              subtitle: address,
                            ),
                          ],
                        ),
                      ),

                      // Right Side - Profile (Centered)
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 80, 78, 78),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 88, 87, 87)),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  size: 60,
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              lead_owner,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 233, 163, 84),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.message,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Spacer
                // History Section

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                      // TimelineTenWid(),
                      SizedBox(
                        height: 10,
                      ),
                      TimelineSevenWid(events: allEvents),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final Map<String, Color> containerColors = {
  'Phone Number': Colors.green.shade400,
  'Email': Colors.blue.shade400,
  'Company': Colors.yellow.shade400,
  'Address': Colors.red.shade400,
};

final Map<String, Color> iconColors = {
  'Phone Number': Colors.white,
  'Email': Colors.white,
  'Company': Colors.white,
  'Address': Colors.white,
};

class ContactRow extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String taskId; // taskId is passed here
  final Color containerBgColor; // Add container background color
  final Color iconColor;

  const ContactRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.taskId,
    required this.containerBgColor,
    required this.iconColor,
  });

  @override
  State<ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<ContactRow> {
  String phoneNumber = 'Loading...';
  String email = 'Loading...';
  String status = 'Loading...';
  String company = 'Loading...';
  String address = 'Loading...';
  String lead_owner = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchSingleIdData(widget.taskId); // Fetch data when widget is initialized
  }

  Future<void> fetchSingleIdData(String taskId) async {
    try {
      final leadData = await LeadsSrv.singleFollowupsById(taskId);
      setState(() {
        phoneNumber = leadData['mobile'] ?? 'N/A';
        email = leadData['lead_email'] ?? 'N/A';
        status = leadData['status'] ?? 'N/A';
        company = leadData['brand'] ?? 'N/A';
        address = leadData['address'] ?? 'N/A';
        lead_owner = leadData['lead_owner'] ?? 'N/A';
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text at the top
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.containerBgColor),
            child: Icon(
              widget.icon,
              size: 25,
              color: widget.iconColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            // Ensure text doesn't overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  softWrap: true, // Allows text wrapping
                  overflow: TextOverflow.visible, // Ensures no cutoff
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
