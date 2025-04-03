import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/config/getX/fab.controller.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/widgets/home_btn.dart/dashboard_popups/appointment_popup.dart';
import 'package:smart_assist/widgets/home_btn.dart/dashboard_popups/create_Followups_popups.dart';
import 'package:smart_assist/widgets/home_btn.dart/dashboard_popups/create_leads.dart';
import 'package:smart_assist/widgets/home_btn.dart/dashboard_popups/create_testDrive.dart';
import 'package:smart_assist/widgets/home_btn.dart/single_ids_popup/appointment_ids.dart';
import 'package:smart_assist/widgets/home_btn.dart/single_ids_popup/followups_ids.dart';
import 'package:smart_assist/widgets/home_btn.dart/single_ids_popup/leads_ids.dart';
import 'package:smart_assist/widgets/home_btn.dart/single_ids_popup/testdrive_ids.dart';
import 'package:smart_assist/widgets/leads_details_popup/create_appointment.dart';
import 'package:smart_assist/widgets/leads_details_popup/create_followups.dart';
import 'package:smart_assist/widgets/timeline/timeline_nine_wid.dart';
import 'package:smart_assist/widgets/timeline/timeline_tasks.dart';
import 'package:smart_assist/widgets/timeline/timeline_events.dart';

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
  String leadSource = 'Loading....';
  String enquiry_type = 'Loading...';
  String purchase_type = 'Loading...';
  String PMI = 'Loading....';
  String fuel_type = 'Loading....';
  String expected_date_purchase = 'Loading...';

  bool isLoading = false;
  // fetchevent data

  List<String> subjectList = [];
  List<String> priorityList = [];
  List<String> startTimeList = [];
  List<String> endTimeList = [];
  List<String> startDateList = [];

  bool _isHidden = false;

  // dropdown
  final Widget _createFollowups = const LeadsCreateFollowup();
  final Widget _createAppoinment = const CreateAppointment();
  // Initialize the controller
  final FabController fabController = Get.put(FabController());
  String leadId = '';
  int _childButtonIndex = 0;

  @override
  void initState() {
    super.initState();
    print(widget.leadId);
    print(
        'this is the liead by in the single ovedue 333333333333333333333333333333333333333333333333333333333333333333333');
    fetchSingleIdData(widget.leadId);
    fetchSingleTask(widget.leadId);
    fetchTestDrive(widget.leadId, 'Test%20Drive');
    fetchSingleEvents(widget.leadId);
    // fetchSingleTask(widget.leadId);
  }

  String formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      return DateFormat("d MMM").format(parsedDate); // Outputs "22 May"
    } catch (e) {
      print('Error formatting date: $e');
      return 'N/A';
    }
  }

  Future<void> fetchSingleIdData(String leadId) async {
    try {
      final leadData = await LeadsSrv.singleFollowupsById(leadId);
      setState(() {
        mobile = leadData['data']['mobile'] ?? 'N/A';
        email = leadData['data']['email'] ?? 'N/A';
        status = leadData['data']['status'] ?? 'N/A';
        company = leadData['data']['brand'] ?? 'N/A';
        address = leadData['data']['address'] ?? 'N/A';
        leadSource = leadData['data']['lead_source'] ?? 'N/A';
        fuel_type = leadData['data']['fuel_type'] ?? 'N/A';
        PMI = leadData['data']['PMI'] ?? 'N/A';
        purchase_type = leadData['data']['purchase_type'] ?? 'N/A';
        enquiry_type = leadData['data']['enquiry_type'] ?? 'N/A';
        expected_date_purchase =
            leadData['data']['expected_date_purchase'] ?? 'N/A';
        lead_owner = leadData['data']['lead_name'] ?? 'N/A';
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _eventAll() {
    setState(() {
      subjectList = [];
      priorityList = [];
      startTimeList = [];
      endTimeList = [];
      startDateList = [];

      final dataSource = allEvents;

      // Iterate through the rows of events
      for (var item in dataSource) {
        // Event data - access the fields directly from the item, not 'data'
        subjectList.add(item['subject'] ?? 'N/A');
        priorityList.add(item['priority'] ?? 'N/A');
        startTimeList.add(_formatTime(item[
            'start_time'])); // Assuming _formatTime is a method you defined
        endTimeList.add(_formatTime(item['end_time']));
        startDateList.add(item['start_date'] ?? 'N/A');
      }
    });
  }

  void _taskAll() {
    setState(() {
      subjectList = [];
      priorityList = [];
      startTimeList = [];
      endTimeList = [];
      startDateList = [];

      // Choose the data source based on the button index
      final dataSource = allTasks;

      // Iterate through the dataSource (either allEvents or allTasks)
      for (var item in dataSource) {
        // Event data
        subjectList.add(item['subject'] ?? 'N/A');
        priorityList.add(item['priority'] ?? 'N/A');
        startTimeList.add(_formatTime(item['start_time']));
        endTimeList.add(_formatTime(item['end_time']));
        startDateList.add(item['due_date'] ?? 'N/A');
      }
    });
  }

  List<Map<String, dynamic>> allEvents = [];
  List<Map<String, dynamic>> allTasks = [];
  List<Map<String, dynamic>> allTestdrive = [];

  Future<void> fetchSingleTask(String leadId) async {
    setState(() => isLoading = true);
    try {
      // Fetch API response
      final List<Map<String, dynamic>> events =
          await LeadsSrv.singleTaskById(leadId);

      setState(() {
        allEvents = events;
        // if (_childButtonIndex == 0) {
        _eventAll();
        // }
      });
    } catch (e) {
      print('Error Fetching events: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchSingleEvents(String leadId) async {
    setState(() => isLoading = true);
    try {
      // Fetch API response
      final List<Map<String, dynamic>> tasks =
          await LeadsSrv.singleTasksById(leadId); // No need to decode here

      setState(() {
        allTasks = tasks;
        // if (_childButtonIndex == 1) {
        _taskAll();
        // }
      });
    } catch (e) {
      print('Error Fetching tasks: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchTestDrive(String leadId, String subject) async {
    setState(() => isLoading = true);
    try {
      // Fetch API response
      final List<Map<String, dynamic>> events =
          await LeadsSrv.singleTestDriveById(leadId, subject);

      setState(() {
        allEvents = events;
        // if (_childButtonIndex == 0) {
        _eventAll();
        // }
      });
    } catch (e) {
      print('Error Fetching events: $e');
    } finally {
      setState(() => isLoading = false);
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundLightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLightGrey,
        title: Text('Enquiry', style: AppFont.appbarfontgrey(context)),
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [],
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: AppColors.iconGrey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Stack(children: [
        Scaffold(
          body: Container(
            width: double.infinity, // ✅ Ensures full width
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundLightGrey,
            ),
            child: SafeArea(
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              // Profile Section (Icon, Name, Divider, Gmail, Car Name)
                              Row(
                                children: [
                                  // Profile Icon and Name
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              textAlign: TextAlign.left,
                                              lead_owner,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(company,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text(
                                        email,
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColors.iconGrey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                              ),

                              const SizedBox(height: 10),

                              // Contact Details Section (Phone, Company, Address)
                              Row(
                                children: [
                                  // Left Section: Phone Number and Company
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.phone,
                                      title: 'Phone Number',
                                      subtitle: mobile,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.location_on,
                                      title: 'Company',
                                      subtitle: company,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.alt_route_outlined,
                                      title: 'Status',
                                      subtitle:
                                          status, // Replace with the actual address variable
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.person,
                                      title: 'Address',
                                      subtitle:
                                          'Malad', // Replace with the actual address variable
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Left Section: Phone Number and Company
                                  Expanded(
                                    child: _buildContactRow(
                                      icon:
                                          Icons.account_balance_wallet_outlined,
                                      title: 'Car budget',
                                      subtitle: '2xxxxxxx',
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.directions_car,
                                      title: 'Brand',
                                      subtitle: PMI,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.directions_car,
                                      title: 'Purchase type',
                                      subtitle:
                                          purchase_type, // Replace with the actual address variable
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.local_gas_station,
                                      title: 'Fuel type',
                                      subtitle:
                                          fuel_type, // Replace with the actual address variable
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Left Section: Phone Number and Company
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.calendar_month,
                                      title: 'Expected purchase date',
                                      subtitle:
                                          formatDate(expected_date_purchase),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildContactRow(
                                      icon: Icons.directions_car,
                                      title: 'Enquiry type',
                                      subtitle: enquiry_type,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 10), // Spacer
                      // History Section
                      // Text('hiii'),

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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('History',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  },
                                  child: Text(
                                    _isHidden ? 'Show' : 'Hide',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),

                            // Show only if _isHidden is false
                            if (!_isHidden) ...[
                              // Filter buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF767676)
                                                .withOpacity(0.3),
                                            width: 0.6),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        children: [
                                          // Followups Button
                                          Expanded(
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _childButtonIndex = 0;
                                                    _eventAll();
                                                    if (allEvents.isEmpty) {
                                                      fetchSingleTask(
                                                          widget.leadId);
                                                    }
                                                  });
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      _childButtonIndex == 0
                                                          ? Colors.blue
                                                          : Colors.transparent,
                                                  foregroundColor:
                                                      _childButtonIndex == 0
                                                          ? Colors.white
                                                          : Colors.black,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Followups',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          _childButtonIndex == 0
                                                              ? Colors.white
                                                              : Colors.black),
                                                )),
                                          ),

                                          // Appointments Button
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _childButtonIndex = 1;
                                                  _taskAll();
                                                  if (allTasks.isEmpty) {
                                                    fetchSingleTask(
                                                        widget.leadId);
                                                  }
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    _childButtonIndex == 1
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                foregroundColor:
                                                    _childButtonIndex == 1
                                                        ? Colors.white
                                                        : Colors.black,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              child: Text('Appointments',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          _childButtonIndex == 1
                                                              ? Colors.white
                                                              : Colors.black)),
                                            ),
                                          ),

                                          // Test Drive Button
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _childButtonIndex = 2;
                                                  _eventAll();
                                                  if (allEvents.isEmpty) {
                                                    fetchTestDrive(
                                                        widget.leadId,
                                                        'Test%20Drive');
                                                  }
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    _childButtonIndex == 2
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                foregroundColor:
                                                    _childButtonIndex == 2
                                                        ? Colors.white
                                                        : Colors.black,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              child: Text('Test Drive',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          _childButtonIndex == 2
                                                              ? Colors.white
                                                              : Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Data Section
                              isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 0),
                                        if (_childButtonIndex == 0)
                                          allEvents.isNotEmpty
                                              ? TimelineSevenWid(
                                                  events: allEvents)
                                              : const Center(
                                                  child: Text(
                                                    textAlign: TextAlign.start,
                                                    "No Events Found....",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )
                                        else if (_childButtonIndex == 1)
                                          allTasks.isNotEmpty
                                              ? TimelineEightWid(
                                                  events: allTasks)
                                              : const Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    "No Tasks Found...",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )
                                        else if (_childButtonIndex == 2)
                                          allTestdrive.isNotEmpty
                                              ? TimelineNineWid(
                                                  testDrive: allTestdrive)
                                              : const Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    "No Test Drive Found...",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                      ],
                                    ),
                            ]
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Floating Action Button

        Positioned(
          bottom: 16,
          right: 16,
          child: _buildFloatingActionButton(context),
        ),

        // Popup Menu (Conditionally Rendered)
        Obx(() => fabController.isFabExpanded.value
            ? _buildPopupMenu(context)
            : SizedBox.shrink()),
      ]),
    );
  }

// FAB Builder
  Widget _buildFloatingActionButton(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: fabController.toggleFab,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width * .15,
          height: MediaQuery.of(context).size.height * .08,
          decoration: BoxDecoration(
            color: fabController.isFabExpanded.value
                ? Colors.red
                : AppColors.colorsBlue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AnimatedRotation(
              turns: fabController.isFabExpanded.value ? 0.25 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                fabController.isFabExpanded.value ? Icons.close : Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Popup Menu Builder
  Widget _buildPopupMenu(BuildContext context) {
    return GestureDetector(
      onTap: fabController.closeFab,
      child: Stack(
        children: [
          // Background overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),

          // Popup Items Container aligned bottom right
          Positioned(
            bottom: 90,
            right: 20,
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPopupItem(Icons.call, "Followup", -40, onTap: () {
                    fabController.closeFab();
                    _showFollowupPopup(context, widget.leadId);
                  }),
                  _buildPopupItem(
                      Icons.calendar_month_outlined, "Appointment", -80,
                      onTap: () {
                    fabController.closeFab();
                    _showAppointmentPopup(context , widget.leadId);
                  }),
                  // _buildPopupItem(Icons.people_alt_rounded, "Lead", -60,
                  //     onTap: () {
                  //   fabController.closeFab();
                  //   _showLeadPopup(context);
                  // }),
                  _buildPopupItem(Icons.directions_car, "Test Drive", -20,
                      onTap: () {
                    fabController.closeFab();
                    _showTestdrivePopup(context , widget.leadId);
                  }),
                ],
              ),
            ),
          ),

          // ✅ FAB positioned above the overlay
          Positioned(
            bottom: 16,
            right: 16,
            child: _buildFloatingActionButton(context),
          ),
        ],
      ),
    );
  }

  // Popup Item Builder
  Widget _buildPopupItem(IconData icon, String label, double offsetY,
      {required Function() onTap}) {
    return Obx(() => TweenAnimationBuilder(
          tween: Tween<double>(
              begin: 0, end: fabController.isFabExpanded.value ? 1 : 0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, offsetY * (1 - value)),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onTap,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.colorsBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(icon, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class ContactRow extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String taskId;

  const ContactRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.taskId,
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
        phoneNumber = leadData['data']['mobile'] ?? 'N/A';
        email = leadData['data']['lead_email'] ?? 'N/A';
        status = leadData['data']['status'] ?? 'N/A';
        company = leadData['data']['brand'] ?? 'N/A';
        address = leadData['data']['address'] ?? 'N/A';
        lead_owner = leadData['data']['lead_owner'] ?? 'N/A';
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
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 241, 248, 255)),
            child: Icon(
              widget.icon,
              size: 25,
              color: Colors.blue,
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
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.fontColor),
                ),
                // const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.fontBlack),
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

class NavigationController extends GetxController {
  final RxBool isFabExpanded = false.obs;

  void toggleFab() {
    // Add a slight delay to ensure smooth animation
    Future.delayed(const Duration(milliseconds: 50), () {
      HapticFeedback.lightImpact();
      isFabExpanded.toggle();
    });
  }
}

// // ✅ Function to Show `CreateFollowupsPopups` on "Lead"
// void _showLeadPopup(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.zero,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           margin: const EdgeInsets.symmetric(
//               horizontal: 16), // Add some margin for better UX
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const LeadsIds(),
//         ),
//       );
//     },
//   );
// }

// ✅ Function to Show `CreateFollowupsPopups` on "Lead"
void _showFollowupPopup(BuildContext context, String leadId) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Add some margin for better UX
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FollowupsIds(leadId: leadId),
        ),
      );
    },
  );
}

void _showAppointmentPopup(BuildContext context, String leadId) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero, // Remove default padding
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Add margin for better UX
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child:   AppointmentIds(leadId : leadId), // Appointment modal
        ),
      );
    },
  );
}

void _showTestdrivePopup(BuildContext context, String leadId) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero, // Remove default padding
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Add margin for better UX
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child:   TestdriveIds(leadId : leadId), // Appointment modal
        ),
      );
    },
  );
}
