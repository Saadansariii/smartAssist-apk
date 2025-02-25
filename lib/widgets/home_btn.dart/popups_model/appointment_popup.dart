import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';

class AppointmentPopup extends StatefulWidget {
  const AppointmentPopup({super.key});

  @override
  State<AppointmentPopup> createState() => _AppointmentPopupState();
}

class _AppointmentPopupState extends State<AppointmentPopup> {
  // List<String> dropdownItems = [];
  List<Map<String, String>> dropdownItems = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    const String apiUrl = "https://api.smartassistapp.in/api/leads/all";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rows = data['rows'] as List;

        setState(() {
          dropdownItems = rows.map((row) {
            return {
              "name": row['lead_name'] as String,
              "id": row['lead_id'] as String,
            };
          }).toList();
        });

        isLoading = false;
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print("Error fetching dropdown data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String? selectedLeads;
  String? selectedSubject;
  String? selectedStatus;
  String? selectedPriority;

  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();

  // TextEditingController descriptionController = TextEditingController();

  Future<void> _pickDate({required bool isStartDate}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Combine Date and Time
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          // Format Date & Time as 'dd/MM/yyyy hh:mm a'
          String formattedDateTime =
              DateFormat('dd/MM/yyyy hh:mm a').format(combinedDateTime);

          if (isStartDate) {
            startdateController.text = formattedDateTime;
          } else {
            enddateController.text = formattedDateTime;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create Appoinment',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              _buildDropdown(
                label: 'Priority:',
                hint: 'Select',
                value: selectedPriority,
                items: ['High', 'Normal', 'Low'],
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value;
                  });
                  print("Selected Brand: $selectedPriority ");
                },
              ),

              _buildDropdown(
                label: 'Subject:',
                hint: 'Select',
                value: selectedSubject,
                items: [
                  "Meeting",
                  "Test Drive",
                  "Showroom appointment",
                  "Service Appointment",
                  "Quotation",
                  "Trade in evaluation"
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                  });
                  print("Selected Brand: $selectedSubject");
                },
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Leads Name :',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.containerPopBg,
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButton<String>(
                        value: selectedLeads,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Select",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: dropdownItems.map((item) {
                          return DropdownMenuItem<String>(
                            value: item["id"],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(item["name"] ?? '',
                                  style: AppFont.dropDowmLabel()),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              selectedLeads = value;
                            },
                          );
                        },
                      ),
              ),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Start Date',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () => _pickDate(isStartDate: true),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.containerPopBg,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          startdateController.text.isEmpty
                              ? "Select Date"
                              : startdateController.text,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: startdateController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        // color: AppColors.colorsBlue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('End Date',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () => _pickDate(isStartDate: false),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.containerPopBg,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          enddateController.text.isEmpty
                              ? "Select Date"
                              : enddateController.text,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: enddateController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        // color: AppColors.colorsBlue,
                      ),
                    ],
                  ),
                ),
              ),

              // buttons
              const SizedBox(height: 30),
              // Row with Buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.black, // Cancel button color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close modal on cancel
                        },
                        child: Text('Cancel', style: AppFont.buttons()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          submitForm();
                        },
                        child: Text('Submit', style: AppFont.buttons()),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> submitForm() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? spId = prefs.getString('user_id');

  //   // Use the lead id from the dropdown selection
  //   if (selectedLeads == null) {
  //     showErrorMessage(context, message: 'Please select a lead.');
  //     return;
  //   }
  //   String leadId = selectedLeads!;

  //   // Convert the selected date-time into DateTime objects
  //   DateTime startDateTime =
  //       DateFormat('dd/MM/yyyy hh:mm a').parse(startdateController.text);
  //   DateTime endDateTime =
  //       DateFormat('dd/MM/yyyy hh:mm a').parse(enddateController.text);

  //   // Extract date in 'yyyy-MM-dd' format
  //   String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDateTime);
  //   String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDateTime);

  //   // Extract time in 'hh:mm a' format
  //   String formattedStartTime = DateFormat('hh:mm a').format(startDateTime);
  //   String formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

  //   print('Retrieved sp_id: $spId');
  //   print('Retrieved lead_id: $leadId');
  //   print('Selected lead id from dropdown: $selectedLeads');

  //   if (spId == null || leadId.isEmpty) {
  //     showErrorMessage(context,
  //         message: 'User ID or Lead ID not found. Please log in again.');
  //     return;
  //   }

  //   // Prepare the appointment data
  //   final newTaskForLead = {
  //     'start_date': startdateController.text,
  //     'end_date': enddateController.text,
  //     'priority': selectedPriority,
  //     'start_time': formattedStartTime,
  //     'end_time': formattedEndTime,
  //     'subject': selectedSubject,
  //     'sp_id': spId,
  //   };

  //   print('Lead Data: $newTaskForLead');

  //   // Pass the selected leadId to the submitAppoinment function
  //   bool success = await LeadsSrv.submitAppoinment(newTaskForLead, leadId);

  //   if (success) {
  //     print('Lead submitted successfully!');
  //     if (context.mounted) {
  //       Navigator.pop(context);
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Form Submit Successful.')),
  //     );
  //   } else {
  //     print('Failed to submit lead.');
  //   }
  // }

  Future<void> submitForm() async {
    // Retrieve sp_id from SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    final spId = prefs.getString('user_id');

    // Use the lead id from the dropdown selection.
    if (selectedLeads == null) {
      showErrorMessage(context, message: 'Please select a lead.');
      return;
    }
    final leadId = selectedLeads!;

    // Parse and format the selected dates/times.
    final startDateTime =
        DateFormat('dd/MM/yyyy hh:mm a').parse(startdateController.text);
    final endDateTime =
        DateFormat('dd/MM/yyyy hh:mm a').parse(enddateController.text);
    final formattedStartTime = DateFormat('hh:mm a').format(startDateTime);
    final formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

    if (spId == null || leadId.isEmpty) {
      showErrorMessage(context,
          message: 'User ID or Lead ID not found. Please log in again.');
      return;
    }

    // Prepare the appointment data.
    final appointmentData = {
      'start_date': startdateController.text,
      'end_date': enddateController.text,
      'priority': selectedPriority,
      'start_time': formattedStartTime,
      'end_time': formattedEndTime,
      'subject': selectedSubject,
      'sp_id': spId,
    };

    // Call the service to submit the appointment.
    final success = await LeadsSrv.submitAppoinment(appointmentData, leadId);

    if (success) {
      if (context.mounted) {
        Navigator.pop(context, true); // Close the modal on success.
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submit Successful.')),
      );
    } else {
      showErrorMessage(context, message: 'Failed to submit appointment.');
    }
  }
}

// Reusable Dropdown Builder
Widget _buildDropdown({
  required String label,
  required String hint,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.containerPopBg,
        ),
        child: DropdownButton<String>(
          value: value,
          hint: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              hint,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          icon: const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: AppColors.fontColor,
              size: 25,
            ),
          ),
          isExpanded: true,
          underline: const SizedBox.shrink(),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  item,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
