import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';

class TaskFollowupsPop extends StatefulWidget {
   final DateTime? selectedDate; 
  const TaskFollowupsPop({super.key, required this.selectedDate});

  @override
  State<TaskFollowupsPop> createState() => _TaskFollowupsPopState();
}

class _TaskFollowupsPopState extends State<TaskFollowupsPop> {
   DateTime? selectedDate; 
  List<String> dropdownItems = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchDropdownData();
    print('this is the second page ${selectedDate = widget.selectedDate!}');
  }

  Future<void> fetchDropdownData() async {
    const String apiUrl = "https://api.smartassistapp.in/api/leads/all";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rows = data['rows'] as List;

        print("Extracted Rows: $rows"); // Debug: Ensure rows are extracted

        if (rows.isNotEmpty) {
          // Extract the lead_id from the first row (or any row you need)
          String leadId =
              rows[0]['lead_id']; // Assuming you're taking the first lead_id
          storeLeadId(leadId); // Store lead_id in SharedPreferences
        }

        setState(() {
          dropdownItems = rows.map<String>((row) {
            String leadName = row['lead_name'] ??
                "${row['fname'] ?? ''} ${row['lname'] ?? ''}".trim();
            return leadName.isNotEmpty ? leadName : "Unknown"; // Default name
          }).toList();

          isLoading = false;
        });

        print(
            "Dropdown Items: $dropdownItems"); // Debug: Ensure dropdown is populated
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching dropdown data: $e");
    }
  }

// Store lead_id in SharedPreferences
  Future<void> storeLeadId(String leadId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'lead_id', leadId); // Save lead_id in SharedPreferences
    print("Stored lead_id: $leadId"); // Debugging
  }

  String? selectedLeads;
  String? selectedSubject;
  String? selectedStatus;
  String? selectedPriority;
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        // Format the date as 'dd/MM/yyyy'
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      'Create Followups',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Comments :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: double.infinity, // Full width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
                ),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Add Comments",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Leads Name :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
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
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: dropdownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                value,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
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

              _buildDropdown(
                label: 'Subject:',
                hint: 'Select',
                value: selectedSubject,
                items: [
                  'Call',
                  'Provide Quotation',
                  'Send Email',
                  'Vehicle Selection',
                  'Send SMS',
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                  });
                  print("Selected Brand: $selectedSubject");
                },
              ),

              _buildDropdown(
                label: 'Status:',
                hint: 'Select',
                value: selectedStatus,
                items: [
                  'Not Started',
                  'In Progress',
                  'Completed',
                  'Waiting on someone else',
                  'Deferred',
                  'SMS sent'
                ],
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                  print("Selected Brand: $selectedStatus");
                },
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
              const SizedBox(height: 10),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text('Followup Date',
              //       style:
              //           TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              // ),
              // const SizedBox(height: 10),

              // GestureDetector(
              //   onTap: _pickDate,
              //   child: Container(
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       color: const Color.fromARGB(255, 243, 238, 238),
              //     ),
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              //     child: Text(
              //       dateController.text.isEmpty
              //           ? "Select Date"
              //           : dateController.text,
              //       style: GoogleFonts.poppins(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w500,
              //         color: dateController.text.isEmpty
              //             ? Colors.grey
              //             : Colors.black,
              //       ),
              //     ),
              //   ),
              // ),

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
                        child: Text('Cancel',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
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
                        child: Text('Submit',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
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

  Future<void> submitForm() async {
    String description = descriptionController.text;
    String date = dateController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spId = prefs.getString('user_id');
    String? leadId = prefs.getString('lead_id');

    print('Retrieved sp_id: $spId');
    print('Retrieved lead_id: $leadId');

    if (spId == null || leadId == null) {
      showErrorMessage(context,
          message: 'User ID or Lead ID not found. Please log in again.');
      return;
    }

    // Prepare the lead data
    final newTaskForLead = {
      'subject': selectedSubject,
      'status': selectedStatus,
      'priority': selectedPriority,
      'due_date': dateController.text,
      'comments': descriptionController.text,
      'sp_id': spId,
    };

    print('Lead Data: $newTaskForLead');

    // Pass the leadId to the submitFollowups function
    bool success = await LeadsSrv.submitFollowups(newTaskForLead, leadId);

    if (success) {
      print('Lead submitted successfully!');

      // Close modal if submission is successful
      if (context.mounted) {
        Navigator.pop(context); // Closes the modal
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submit Successful.')),
      );
    } else {
      print('Failed to submit lead.');
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
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 243, 238, 238),
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
